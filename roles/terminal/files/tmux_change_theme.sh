#!/bin/bash

# FIXME check arguments
HOMEDIR="$1"
THEMEDIR="$2"
SELECTED_THEME="$3"

# Create symlink to the theme file that will be sourced from vimrc.
# FIXME check if exists?
rm "${THEMEDIR}/current_tmux_theme.conf"
ln -s "${THEMEDIR}/tmux_theme_${SELECTED_THEME}.conf" "${THEMEDIR}/current_tmux_theme.conf"

# Reload tmux theme configuration.
tmux source-file "${THEMEDIR}/current_tmux_theme.conf"


