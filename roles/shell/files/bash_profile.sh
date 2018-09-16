# ~/.bash_profile: executed by bash(1) for login shells.

# Enforce correct locales from the beginning.
# LANG=fr_FR.UTF-8 is used, except for the following:
# LC_MESSAGES=C so we never translate program output.
# LC_TIME=en_DK leads to yyyy-mm-dd hh:mm date/time output.
export LANG=fr_FR.UTF-8
export LC_MESSAGES=C
# FIXME following disabled, cause problems with i3 status bar
#export LC_TIME=en_DK.UTF-8
# LC_ALL is unset since it overwrites everything.
unset LC_ALL

# Use XToolkit in java applications
# FIXME to check
export AWT_TOOLKIT=XToolkit

# Enable core dumps in case something goes wrong
# FIXME use systemctl conf
ulimit -c unlimited

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    # Autostart X session at login on tty1 if not already started
    exec startx
    # NB: everything after executing the "exec" command will be ignored, even
    # after the X session is ended.
fi

# If we end up here, then we are not starting an X session.
# In this case, we probably want to configure an interactive shell.
# FIXME check whether the shell is really interactive ? (a non interactive
# login shell should be quite rare)
# FIXME use a different configuration for login shells ?
[[ -f ~/.bashrc ]] && . ~/.bashrc
