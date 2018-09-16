#!/bin/bash

# FIXME check arguments
HOMEDIR="$1"
THEMEDIR="$2"
SELECTED_THEME="$3"

# We cannot force running Vim instances to reload their configuration using a
# signal or anything.
# So we use a somewhat clever (read: ugly and unecessary complex) trick to
# directly send key strokes to these Vim instances using tmux.
# See: https://blog.damonkelley.me/2016/09/07/tmux-send-keys/
function reload_vim_tmux() {
    local panes
    local pane
    # Get list of pane ids running Vim (based on last 6 characters from pane
    # title), in all Tmux sessions and windows.
    panes=$(tmux list-panes -a -F "#{=-6:pane_title}#{pane_id}" |
                sed -n '/^ - VIM/ s/^.\{6\}//p')
    # FIXME what about Vim running on a remote server (ssh) ? we should exclude
    # these panes ...
    # Send reload keys to Vim instances (and escape to ensure we are in normal
    # mode).
    # FIXME use "jk" ? what about command mode, or other modes ?
    # FIXME add a map in vimrc (like C-[) that works like ESC in all modes
    if [ -n "$panes" ]; then
        for pane in $panes; do
            tmux send-keys -t $pane "jk:so ${THEMEDIR}/current_theme.vim" Enter
            tmux send-keys -t $pane ":redraw" Enter
            tmux send-keys -t $pane ":AirlineRefresh" Enter
        done
    fi
    # FIXME if the previous fails, maybe use "-l" option, and then send only "Enter"
}



# Create symlink to the theme file that will be sourced from vimrc.
# FIXME check if exists?
rm "${THEMEDIR}/current_theme.vim"
ln -s "${THEMEDIR}/vim_theme_${SELECTED_THEME}.vim" "${THEMEDIR}/current_theme.vim"

reload_vim_tmux



