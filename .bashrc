export LC_COLLATE="C"
export LC_CTYPE="en_US.UTF-8"

eval $(/opt/homebrew/bin/brew shellenv)
source ~/.sdkman/bin/sdkman-init.sh

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[01;37m\]$(__git_ps1 "(%s)")\[\033[01;34m\] \$\[\033[00m\] '

alias ll='ls -ahlF'

export LESSCHARSET=utf-8
export BASH_SILENCE_DEPRECATION_WARNING=1
export COMPOSE_MENU=0

