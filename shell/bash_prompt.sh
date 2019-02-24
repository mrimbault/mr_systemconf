#!/bin/bash

# FIXME add comments

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function parse_git_status {
  noupdated=`git status --porcelain 2> /dev/null | grep -E "^ (M|D)" | wc -l`
  nocommitted=`git status --porcelain 2> /dev/null | grep -E "^(M|A|D|R|C)" | wc -l`

  if [[ $noupdated -gt 0 ]]; then echo -n "*"; fi
  if [[ $nocommitted -gt 0 ]]; then echo -n "+"; fi
}

# Use darker colors for prompt, to avoid distraction.
GRAY="\[\033[00;30m\]"
RED="\[\033[00;31m\]"
GREEN="\[\033[00;32m\]"
YELLOW="\[\033[00;33m\]"
BLUE="\[\033[00;34m\]"
MAGENTA="\[\033[00;35m\]"
CYAN="\[\033[00;36m\]"
WHITE="\[\033[00;37m\]"
NC="\[\033[0m\]"

# FIXME use an Ansible template and adapt colors depending on theme?
PS1="\n"
PS1+="$CYAN\$(date +%Y%m%d-%H:%M) "
PS1+="\u@\h "
PS1+="\w"
PS1+="$YELLOW\$(parse_git_branch)\$(parse_git_status) "
PS1+="\n "
PS1+="$NC"
