defaults write com.apple.dock orientation left
killall Dock

# This doesn't take effect until restart
defaults write "Apple Global Domain" "AppleInterfaceStyle" -string "Dark"
