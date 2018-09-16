#!/bin/bash
#
# Inspired from: https://github.com/DaveDavenport/RandomScripts/blob/master/banginator.sh
# Depends on:
# - rofi: https://github.com/DaveDavenport/rofi
# - mons: https://github.com/Ventto/mons
# - i3 (i3-nagbar): https://build.i3wm.org/docs/i3-nagbar.html

# FIXME add possibility to change resolution, primary / secondary role, etc.

# Define arrays used to store choices to be displayed and associated commands.
declare -A TITLES
declare -A COMMANDS

# Detect number of available monitors.
mon_nb=$(mons | sed -n '/^Monitors:/ s/^Monitors:\s\+//p')
# Get verbose list of available monitors.
monitors="$(mons)"

# If only one monitor is connected (or none, obviously), no point to go further.
if [ $mon_nb -lt 2 ]; then
    # FIXME get i3 font?
    i3-nagbar -t warning -m 'Only one monitor is connected.'
    exit 0
fi

# If more than two monitors are connected, don't allow to chose layouts.
# mons allows to configure the layout for three monitors, but that would be
# a more complicated menu. At this point, better use directly mons from
# a terminal.
if [ $mon_nb -gt 2 ]; then
    # FIXME get i3 font?
    i3-nagbar -t warning -m 'More than two monitors are connected, use "mons" or "xrandr" to configure layout.'
    exit 0
fi

# Now we know we have two monitors available.
# Prepare text to show on menu.
MESG="Choose the monitor layout.
<b>Escape</b> to cancel
<i>${monitors}</i>"

# List of layout choices.

# FIXME how to sort / align choices ?
COMMANDS['!o']="mons -o"
TITLES['!o']="Primary monitor only"

COMMANDS['!s']="mons -s"
TITLES['!s']="Secondary monitor only"

COMMANDS['!d']="mons -d"
TITLES['!d']="Duplicate monitors"

COMMANDS['!m']="mons -m"
TITLES['!m']="Mirror monitors"

COMMANDS['!l']="mons -e left"
TITLES['!l']="Dual, secondary monitor on the left"

COMMANDS['!r']="mons -e right"
TITLES['!r']="Dual, secondary monitor on the right"

COMMANDS['!b']="mons -e bottom"
TITLES['!b']="Dual, secondary monitor on the bottom"

COMMANDS['!t']="mons -e top"
TITLES['!t']="Dual, secondary monitor on the top"


##
# Generate menu
##
function print_menu()
{
    for key in ${!TITLES[@]}
    do
        echo "$key    ${TITLES[$key]}"
    done
}
##
# Show rofi.
##
function start()
{
    print_menu | rofi -dmenu -p "Layout" -mesg "$MESG"
}


# Run it.
value="$(start)"

# Split input, and grab up to first space.
choice=${value%%\ *}
# Graph remainder, minus space.
input=${value:$((${#choice}+1))}

##
# Cancelled? bail out
##
if test -z ${choice}
then
    exit
fi

# Check if choice exists.
if test ${COMMANDS[$choice]+isset}
then
    # Execute the choice.
    eval echo "Executing: ${COMMANDS[$choice]}"
    eval ${COMMANDS[$choice]}
else
    echo "Unknown command: ${choice}" | rofi -dmenu -p "Error"
fi
