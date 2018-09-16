#!/bin/bash

# FIXME check arguments
HOMEDIR="$1"
THEMEDIR="$2"
SELECTED_THEME="$3"

# FIXME this script must have been created
replace_file_section "${HOMEDIR}/.config/i3/config" \
    "${THEMEDIR}/i3_theme_${SELECTED_THEME}" \
    "I3WM"

# FIXME this script must have been created
replace_file_section "${HOMEDIR}/.config/i3/config" \
    "${THEMEDIR}/i3bar_theme_${SELECTED_THEME}" \
    "I3BAR"

# Reload i3 configuration.
i3-msg reload




