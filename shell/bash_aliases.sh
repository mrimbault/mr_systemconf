# Enable color support of ls and also add handy color-related aliases.
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # Default diff to colordiff with git style.
    alias diff='colordiff -u'
fi

# Some more ls aliases.
alias ll='ls -alF'
alias la='ls -A'
alias lt='ls -alFrt'
alias l='ls -CF'

# Change mount output to an aligned one.
alias mount='mount | column --table'

# While atop is installed, no reason to use plain top.
alias top='atop'

# Vim aliases.
alias vi='vim'
alias view='vim -R'

# Autojump alias.
alias j="autojump"

# Get external IP address.
alias myip="curl ipecho.net/plain; echo"

# I used to have an alias on which(1) that extended it to find aliases, until I
# found about the type(1P) command.

# FIXME alias rm for safer behaviour?
# show argument full list and ask for validation (even with -f)
# mark several directories (like ~ or /) as "non removables"
# http://repo.or.cz/w/safe-rm.git
# https://docstore.mik.ua/orelly/unix3/upt/ch14_04.htm
#
# I'm really unsure about this, as long as rm(1) has no safety net by default
# on most systems, I don't want to become relaxed about its use, I want to keep
# the paranoid double-checks.

# FIXME breaks completion
# Alias ssh to avoid running into problems due to sending TERM=tmux
alias ssh='TERM=xterm-color ssh'
# Same with vagrant ssh to avoid running into problems due to sending TERM=tmux
alias vssh='TERM=xterm-color vagrant ssh'

