#!/bin/bash

DOT_PATH="$HOME/work/src/dotfiles"

if [ ! -d "$DOT_PATH" ]; then
    echo "Error: Directory $DOT_PATH does not exist."
    exit 1
fi
cd "$DOT_PATH" || exit 1

# home dir
for file in .??*; do
    [[ "$file" = ".git" ]] && continue
    [[ "$file" = ".DS_Store" ]] && continue
    ln -fvs "$DOT_PATH/$file" "$HOME/$file"
done

# visual-studio-code
VSC_PATH="$HOME/Library/Application\ Support/Code/User"
ln -fvs "$DOT_PATH/vscode/settings.json" "$VSC_PATH/settings.json"
ln -fvs "$DOT_PATH/vscode/keybindings.json" "$VSC_PATH/keybindings.json"
cat "$DOT_PATH/vscode/extensions" | while read line
do
    code --install-extension $line
done
code --list-extensions > "$DOT_PATH/vscode/extensions"

# google-backup-and-sync
ln -fvs "$HOME/drive/IVJ_Secret/ssh_keys" "$HOME/.ssh/ivj_keys"
