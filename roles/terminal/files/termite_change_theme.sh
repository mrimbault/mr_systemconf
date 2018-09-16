#!/bin/bash

# FIXME check arguments
HOMEDIR="$1"
THEMEDIR="$2"
SELECTED_THEME="$3"

# FIXME this script must have been created
replace_file_section "${HOMEDIR}/.config/termite/config" \
    "${THEMEDIR}/termite_theme_${SELECTED_THEME}" \
    "TERMITE"

# Reload configuration for all termite instances.
pkill -SIGUSR1 termite




