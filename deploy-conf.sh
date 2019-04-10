#!/bin/bash
#
# This script is provided to easily deploy or compare configuration files.
#
# Put bash on "strict mode".
# See: http://redsymbol.net/articles/unofficial-bash-strict-mode/
# And: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# Immediately exit on any error.
set -o errexit
# Raise an error when using an undefined variable, instead of silently using
# the empty string.
set -o nounset
# Raise an error when any command involved in a pipe fails, not just the last
# one.
set -o pipefail
# Remove whitespace from default word split characters.
IFS=$'\n\t'
# Variables definition.
script_name="$0"
source_dir="$(dirname "$0")"
dry_run=""
# Declare themes directory.
uts_dir="${HOME}/.local/share/unified-theme-selector"
theme_dir="${uts_dir}/themes"
current_theme_file="${uts_dir}/current_global_theme"
default_theme="badwolf"
selected_theme=""
# Declare source and destination files as an associative array.
declare -A source_dest=(
    # Editor configuration.
    # FIXME add project specific (PG) configuration files?
    ["editor/vimrc"]="${HOME}/.vimrc"
    # Terminal configuration.
    ["terminal/termite"]="${HOME}/.config/termite/config"
    ["terminal/tmux"]="${HOME}/.tmux.conf"
    # Shell configuration.
    ["shell/inputrc.sh"]="${HOME}/.inputrc"
    ["shell/bash_profile.sh"]="${HOME}/.bash_profile"
    ["shell/bashrc.sh"]="${HOME}/.bashrc"
    ["shell/bash_aliases.sh"]="${HOME}/.bashrc.d/bash_aliases.sh"
    ["shell/bash_colored_man.sh"]="${HOME}/.bashrc.d/bash_colored_man.sh"
    ["shell/bash_path.sh"]="${HOME}/.bashrc.d/bash_path.sh"
    ["shell/bash_prompt.sh"]="${HOME}/.bashrc.d/bash_prompt.sh"
    ["shell/env.sh"]="${HOME}/.bashrc.d/env.sh"
    ["shell/lc_language.sh"]="${HOME}/.bashrc.d/lc_language.sh"
    ["shell/postgres_manage.sh"]="${HOME}/.bashrc.d/postgres_manage.sh"
    # X configuration.
    ["x/Xresources"]="${HOME}/.Xresources"
    ["x/xinitrc"]="${HOME}/.xinitrc"
    # Window manager configuration.
    ["wm/i3"]="${HOME}/.config/i3/config"
    ["wm/i3blocks.conf"]="${HOME}/.i3blocks.conf"
    ["wm/rofi"]="${HOME}/.config/rofi/config"
    # Themes.
    # - badwolf
    ["themes/badwolf/i3bar_theme_badwolf"]="${theme_dir}/i3bar_theme_badwolf"
    ["themes/badwolf/i3_theme_badwolf"]="${theme_dir}/i3_theme_badwolf"
    ["themes/badwolf/rofi_theme_badwolf.rasi"]="${theme_dir}/rofi_theme_badwolf.rasi"
    ["themes/badwolf/termite_theme_badwolf"]="${theme_dir}/termite_theme_badwolf"
    ["themes/badwolf/tmux_theme_badwolf.conf"]="${theme_dir}/tmux_theme_badwolf.conf"
    ["themes/badwolf/vim_theme_badwolf.vim"]="${theme_dir}/vim_theme_badwolf.vim"
    # - gruvbox dark medium
    ["themes/gruvbox_dark_medium/i3bar_theme_gruvbox-dark-medium"]="${theme_dir}/i3bar_theme_gruvbox-dark-medium"
    ["themes/gruvbox_dark_medium/i3_theme_gruvbox-dark-medium"]="${theme_dir}/i3_theme_gruvbox-dark-medium"
    ["themes/gruvbox_dark_medium/rofi_theme_gruvbox-dark-medium.rasi"]="${theme_dir}/rofi_theme_gruvbox-dark-medium.rasi"
    ["themes/gruvbox_dark_medium/termite_theme_gruvbox-dark-medium"]="${theme_dir}/termite_theme_gruvbox-dark-medium"
    ["themes/gruvbox_dark_medium/tmux_theme_gruvbox-dark-medium.conf"]="${theme_dir}/tmux_theme_gruvbox-dark-medium.conf"
    ["themes/gruvbox_dark_medium/vim_theme_gruvbox-dark-medium.vim"]="${theme_dir}/vim_theme_gruvbox-dark-medium.vim"
    # - papercolor light
    ["themes/papercolor_light/i3bar_theme_papercolor-light"]="${theme_dir}/i3bar_theme_papercolor-light"
    ["themes/papercolor_light/i3_theme_papercolor-light"]="${theme_dir}/i3_theme_papercolor-light"
    ["themes/papercolor_light/rofi_theme_papercolor-light.rasi"]="${theme_dir}/rofi_theme_papercolor-light.rasi"
    ["themes/papercolor_light/termite_theme_papercolor-light"]="${theme_dir}/termite_theme_papercolor-light"
    ["themes/papercolor_light/tmux_theme_papercolor-light.conf"]="${theme_dir}/tmux_theme_papercolor-light.conf"
    ["themes/papercolor_light/vim_theme_papercolor-light.vim"]="${theme_dir}/vim_theme_papercolor-light.vim"
)
# Declare a second associative array for files to be installed using sudo.
declare -A sudo_source_dest=(
    # systemd configuration.
    ["systemd/getty-tty1-override"]="/etc/systemd/system/getty@tty1.service.d/override.conf"
)

# FIXME create theme files

# FIXME dunstrc configuration file is not deployed

# FIXME symlink creation should be dealt with by unified-theme-selector?

# FIXME Create symbolic link for the currently used theme.
#    src: "{{ theme_dir }}/vim_theme_{{ selected_theme }}.vim"
#    dest: ".vim_current_theme"

# FIXME Create symbolic link for the currently used theme.
#    src: "{{ theme_dir }}/tmux_theme_{{ selected_theme }}.vim"
#    dest: ".tmux_current_theme"

# FIXME need to create simlink "rofi_current_theme.rasi"

die() {
    echo "ERROR: $*"
    exit 1
}

print_usage() {
    printf "Deploy configuration files.
Usage: %s <OPTIONS>
  NOT MANDATORY OPTIONS:
    -n                 Dry-run: show diff with already existing configuration.
    -h                 Print this help.
" "$script_name"
}

# Define out own diff function, so we can throw away errors when diff finds
# that compared files are different.
diff_rc_true() {
    # Use colordiff if installed.
    if command -v colordiff >/dev/null; then
        mydiff="colordiff"
    else
        mydiff="diff"
    fi
    # Execute diff command and throw away "1" return code, as it only indicates
    # that the files are different, not an actual execution error.
    $mydiff "$@" || [ $? -eq 1 ] && true
}

deploy_config() {
    local CMD
    local OPTS
    if [ -z "$dry_run" ]; then
        SUDO="sudo"
        CMD="install"
        OPTS=("-m" "644")
    else
        # When in dry-run mode, just show difference between files, don-t copy
        # them.
        SUDO=""
        CMD="diff_rc_true"
        OPTS=("-s" "-u" "-N")
    fi
    # Loop over the array referencing source files and associated destinations.
    for sfile in "${!source_dest[@]}"; do
        echo "=== Processing:"
        echo install -m 644 "${source_dir}/${sfile}" "${source_dest[$sfile]}"
        # Deploy file to associated destination.
        $CMD "${OPTS[@]}" "${source_dir}/${sfile}" "${source_dest[$sfile]}"
    done
    # Loop over the array referencing source files and associated destinations.
    for sfile in "${!sudo_source_dest[@]}"; do
        echo "=== Processing:"
        echo sudo install -m 644 "${source_dir}/${sfile}" "${sudo_source_dest[$sfile]}"
        # Deploy file to associated destination.
        $SUDO $CMD "${OPTS[@]}" "${source_dir}/${sfile}" "${sudo_source_dest[$sfile]}"
    done
}

# Get arguments.
while getopts 'hn' flag; do
  case "${flag}" in
    h) print_usage
       exit 0 ;;
    n) dry_run="true" ;;
    *) print_usage
       die "Unknown option: ${flag}" ;;
  esac
done

# Deploy configuration files.
deploy_config

# Apply theme to configuration if unified_theme-selector is installed.
if [ -z "$dry_run" ] && command -v unified-theme-selector >/dev/null; then
    # Get previously applied theme if any, or use default.
    if [ -r "$current_theme_file" ]; then
        selected_theme=$(cat "$current_theme_file")
    else
        selected_theme="$default_theme"
    fi
    # Apply configuration.
    unified-theme-selector -T "$selected_theme"
fi

