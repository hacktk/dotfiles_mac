# dotfiles (mac)

## Initialize
```
# change login shell & restart terminal
$ chsh -s /bin/bash

# generate ssh key & manually add it to github
$ ssh-keygen -t ed25519 -C "hacktk3@gmail.com"

# install
$ /bin/bash -c "$(curl -L https://raw.githubusercontent.com/hacktk/dotfiles_mac/master/install.sh)"
```

## After initialize
- Desktop & Screen Saver
    - Desktop - Colors - (Stone)
- Dock & Menu Bar
    - Display - Show in Menu Bar (Uncheck)
    - Sound - Show in Menu Bar - always
    - Now Playing - Show in Menu Bar (Uncheck)
    - Battery - Show Percentage (Check)
    - Spotlight - Show in Menu Bar (Uncheck)
- Keyboard
    - Keyboard
        - Modifier Keys
            - Caps Lock (Change to Control)
            - Control (Change to Command)
            - Command (Change to Control)
    - Input Sources
        - Add
            - Alphanumeric (Google)
            - Hiragana (Google)
        - Delete
            - ABC (After check to `Romaji` in Japan - Romaji Input modes)
            - Japanese - Romaji
