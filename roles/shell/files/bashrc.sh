# ~/.bashrc: executed by bash(1) for non-login shells.
# See: /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples.

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return


# Change Linux virtual terminal colors.
# See: https://wiki.archlinux.org/index.php/Color_output_in_console#Virtual_console
# FIXME to check
if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi


# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Setting bigger history length.
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Enable XON/XOFF flow control: disable terminal freeze on C-s.
stty -ixon

# Create a new tmux session for every terminal (named without imagination with
# a timestamp).
if [[ -z "$TMUX" ]]; then
    timestamp="$(date +%Y%m%d%H%M%S)"
    # FIXME session name ? different tmux sessions with named roles?
    # FIXME function with parameter to set tmux session name (used from i3 maps)?
    tmux new-session -t "${timestamp}"
fi


# Additionnal configuration from .bashrc.d directory.
confdir="$HOME/.bashrc.d"
if [ -d "$confdir" ]; then
    # Source every shell file from bash configuration directory.
    for file in ${confdir}/*.sh; do
        . ${file}
    done
fi
unset confdir

# Source autojump (NB: this modify the PROMPT_COMMAND variable).
. /etc/profile.d/autojump.bash

