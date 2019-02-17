BASH_COMPLETION_PATH=/usr/local/share/bash-completion/bash_completion
if [ "${BASH_VERSINFO[0]}" -ge 4 ] && [ -f "$BASH_COMPLETION_PATH" ]; then
    . "$BASH_COMPLETION_PATH"
fi

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\[\033[01;37m\]$(__git_ps1 "(%s)")\[\033[01;34m\] \$\[\033[00m\] '

alias ll='ls -al'
alias curl='curl -H "Accept-Encoding: gzip,deflate"'

export DOCKER_BUILDKIT=1
