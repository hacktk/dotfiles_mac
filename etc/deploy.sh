#!/bin/bash

DOT_PATH="$HOME/repo/dotfiles_mac"

if [ ! -d "$DOT_PATH" ]; then
    echo "Error: Directory $DOT_PATH does not exist."
    exit 1
fi
cd "$DOT_PATH" || exit 1

mkdir "$HOME/.config"
ln -fvs "$DOT_PATH/git" "$HOME/.config/git"
mkdir "$HOME/repo/org"

# home dir
for file in .??*; do
    [[ "$file" = ".git" ]] && continue
    [[ "$file" = ".DS_Store" ]] && continue
    ln -fvs "$DOT_PATH/$file" "$HOME/$file"
done

# brew
brew bundle --file=etc/Brewfile

# UDEV Gothic
UDEV_GOTHIC_VERSION="v1.3.0"
UDEV_GOTHIC_PATH="/dev/shm/udev-gothic"
CUR_PATH=$(pwd)
mkdir -p $UDEV_GOTHIC_PATH && cd $UDEV_GOTHIC_PATH
curl -L https://github.com/yuru7/udev-gothic/releases/download/$UDEV_GOTHIC_VERSION/UDEVGothic_$UDEV_GOTHIC_VERSION.zip -o ./UDEVGothic.zip
unzip ./UDEVGothic.zip -d ~/Library/Fonts/
cd $CUR_PATH && rm -rf $UDEV_GOTHIC_PATH
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
VSC_PATH="$HOME/Library/Application Support/Code/User"
ln -fvs "$DOT_PATH/vscode/settings.json" "$VSC_PATH/settings.json"
ln -fvs "$DOT_PATH/vscode/keybindings.json" "$VSC_PATH/keybindings.json"

# git
sudo ln -fvs "/opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight" "/usr/local/bin/"
