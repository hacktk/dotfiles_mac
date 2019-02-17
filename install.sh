#!/bin/bash

set -eu

DOT_PATH="$HOME/work/src/dotfiles"

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

etc/configure_mac.sh
echo

etc/deploy.sh
echo

echo "install finished."
