#!/bin/bash

set -eu

# install brew & command line tools
if ! command -v brew > /dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo
fi

DOT_PATH="$HOME/repo/dotfiles"

if [ ! -d "$DOT_PATH" ]; then
    git clone git@github.com:hacktk/dotfiles.git "$DOT_PATH"
else
    echo "$DOT_PATH already downloaded. Updating..."
    cd "$DOT_PATH"
    git stash
    git checkout master
    git pull origin master
    echo
fi

cd "$DOT_PATH"

etc/configure.sh
echo

etc/deploy.sh
echo

echo "install finished."
