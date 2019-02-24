
# FIXME change these on .bash_profile ?
# see: https://gist.github.com/jsjohnst/68455


# put shell on Vi mode (ESC to switch from <insert> to <command> mode)
set editing-mode vi
set show-mode-in-prompt on


# keymap on command mode
set keymap vi-command
"gg": beginning-of-history
"G": end-of-history

# keymap on insert mode
set keymap vi-insert
"jk": vi-movement-mode
"\C-w": backward-kill-word
"\C-p": history-search-backward
"\C-l": clear-screen




# modify cursor style (steady bar for <insert>, steady block for <normal>)
#set vi-ins-mode-string \1\e[6 q\2
#set vi-cmd-mode-string \1\e[4 q\2
# switch to block cursor before executing a command
#set keymap vi-insert
#RETURN: "\e\n"

# add mode symbol on prompt, including color
set vi-ins-mode-string "\1\e[0;33m\2+$\1\e[0m\2\1\e[6 q\2"
#set vi-cmd-mode-string "\1\[\e[43m\]\[\e[0;30m\]\2+$ \1\e[0m\2"
#set vi-cmd-mode-string ":"
#set vi-cmd-mode-string "\1\e[0;34m\2:$ \1\e[0m\2"
#set vi-cmd-mode-string "\1\[\e[44m\]\[\e[0;37m\]\2:$ \1\e[0m\2"
set vi-cmd-mode-string "\1\e[44m\2:$\1\e[0m\2\1\e[4 q\2"


