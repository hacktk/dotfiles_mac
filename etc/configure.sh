#!/bin/bash

set -e

if ! command -v defaults > /dev/null 2>&1; then
    echo "\`defaults\` not found. Nothing to do."
    exit 0
fi

echo "Configuring General..."
defaults write -g AppleLanguages '("en-US")'
# アクセントカラーをGraphiteにする
defaults write -g AppleAccentColor -string "-1"
defaults write -g AppleAquaColorVariant -int 6
defaults write -g AppleHighlightColor -string "0.847059 0.847059 0.862745 Graphite"
# スクロールバーを常に表示
defaults write -g AppleShowScrollBars -string "Always"
# スクロールバーのクリック時はクリックされた場所にジャンプ
defaults write -g AppleScrollerPagingBehavior -int 1
# ネットワークボリュームに.DS_Storeを作らない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# クラッシュリポーターをダイアログではなく通知センターで表示
defaults write com.apple.CrashReporter UseUNC -bool true

echo "Configuring Dock..."
# 自動的に隠す
defaults write com.apple.dock autohide -bool true
# 拡大しない
defaults write com.apple.dock magnification -bool false
# 左に表示
defaults write com.apple.dock orientation -string "left"
# 固定のアプリケーションをクリア
defaults write com.apple.dock persistent-apps -array
# 最近使ったアプリケーションをクリア
defaults write com.apple.dock recent-apps -array
# 起動済みのアプリケーションにインジケータを表示しない
defaults write com.apple.dock show-process-indicators -bool false
# 最近使ったアプリケーションを表示しない
defaults write com.apple.dock show-recents -bool false
# 大きさ
defaults write com.apple.dock tilesize -int 70
# ホットコーナー(左上にmission control)
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# ホットコーナー(左下にスリープ)
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0
killall Dock

echo "Configuring Keyboard..."
# キーリピート
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
# 文頭を自動的に大文字にするを無効
defaults write -g NSAutomaticCapitalizationEnabled -bool false
# スマート引用符とスマートダッシュを無効
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
# Mission Controlのショートカットを無効
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 32 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 34 "<dict><key>enabled</key><false/></dict>"
# Spotlightのショートカットを無効
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"
# アプリケーションウインドウのショートカットを無効
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 33 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 35 "<dict><key>enabled</key><false/></dict>"
# 次の入力ソースを選択をcommand+spaceに変更
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"

echo "Configuring Trackpad..."
# 調べる&データ検出を無効
defaults write -g com.apple.trackpad.forceClick -bool false
# 軌跡の速さ
defaults write -g com.apple.trackpad.scaling -int 2
# スマートズームを無効
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool false
# 回転を無効
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool false
# ページ間のスワイプを無効
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false
# フルスクリーンアプリケーション間のスワイプ、通知センターなどを無効
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -bool false
# Launchpadのジェスチャーを無効
defaults write com.apple.dock showDesktopGestureEnabled -bool false
# デスクトップを表示するジェスチャーを無効
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false

echo "Configuring Menu Bar..."
# サウンドを表示する
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true
# VPNを表示する
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/VPN.menu"
# VPNの接続時間を表示
defaults write com.apple.networkConnect VPNShowTime -bool true
# AirPlayを表示しない
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.airplay" -bool false
defaults write com.apple.airplay showInMenuBarIfPresent -bool false
# 日付時刻フォーマットを指定
defaults write com.apple.menuextra.clock DateFormat -string "M\\U6708d\\U65e5(EEE)  H:mm:ss"
killall SystemUIServer

echo "Configuring HostName..."
sudo scutil --set ComputerName mbp61
sudo scutil --set LocalHostName mbp61

echo

# brew
brew bundle --file=etc/Brewfile
