#!/bin/bash

# This script use sed commands to replace every lines between two markers
# on a configuration file with the content from another file.
# This is a ugly hack used as a substitute for a proper "include" configuration
# feature.

# FIXME check arguments

# FIXME test files
configfile="$1"
includefile="$2"

# FIXME default to string "INCLUDE"
includestring="$3"
INCBEG="## #INCLUDE# #${includestring}# #BEGIN# ##"
INCEND="## #INCLUDE# #${includestring}# #END# ##"

# Backup old configuration file so we can rollback.
# FIXME chose a better suffix?
cp -p $configfile ${configfile}.before_replaced
# The sed command works like this:
# - print all lines until the include section begin string $INCBEG ;
# - read the file to be included and print it after $INCBEG ;
# - print all lines from section end $INCEND to the end of the file.
sed -n \
    -e "1,/${INCBEG}/p" \
    -e "/${INCBEG}/r ${includefile}" \
    -e "/${INCEND}/,\$p" \
    ${configfile}.before_replaced > $configfile

# FIXME test RC
# FIXME rollback old file if error?

