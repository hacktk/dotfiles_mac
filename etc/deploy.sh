#!/bin/bash

DOT_PATH="$HOME/repo/dotfiles_mac"

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

# brew
brew bundle --file=etc/Brewfile

# ricty
cp -f /opt/homebrew/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -fv

# terminal
TERMINAL_PROFILE="Simple"
CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')"
if [ "${CURRENT_PROFILE}" != "${TERMINAL_PROFILE}" ]; then
    open "$DOT_PATH/terminal/$TERMINAL_PROFILE.terminal"
    defaults write com.apple.Terminal "Default Window Settings" -string "$TERMINAL_PROFILE"
    defaults write com.apple.Terminal "Startup Window Settings" -string "$TERMINAL_PROFILE"
fi
defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"
sudo dscl . -create /Users/$USER UserShell /opt/homebrew/bin/bash

# visual-studio-code
cat "$DOT_PATH/vscode/extensions" | while read line
do
    code --install-extension $line
done
code --list-extensions > "$DOT_PATH/vscode/extensions"
VSC_PATH="$HOME/Library/Application Support/Code/User"
ln -fvs "$DOT_PATH/vscode/settings.json" "$VSC_PATH/settings.json"
ln -fvs "$DOT_PATH/vscode/keybindings.json" "$VSC_PATH/keybindings.json"

# git
sudo ln -fvs "/opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight" "/usr/local/bin/"

# terraform
mkdir -p "$HOME/.terraform.d/plugin-cache"
tfenv install latest
tfenv use latest
terraform -install-autocomplete

# node
nodenv install $(nodenv install -l | grep -E '^16' | grep -v dev | tail -1)
nodenv global $(nodenv versions | tail -1 | tr '*' ' ' | awk '{print $1}')
