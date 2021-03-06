#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

echo "Creating a new SSH key..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Installing xcode-stuff..."
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git

echo "Git config"
read -p "Enter user.name: " name
read -p "Enter user.email: " email

git config --global user.name "$name"
git config --global user.email $email

echo "Installing brew stuff..."
brew install gnupg
brew install vim
brew install grep
brew install openssh
brew install python
brew install tree
brew install python3

echo "Installing dotfiles..."
git clone git@github.com:hedengran/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./dotfiles_install.sh

echo "Setting macOS settings..."
./macos_settings.sh

apps=(
    bitwarden
    emacs
    firefox
    flux
    intellij-idea-ce
    iterm2
    mactex
    skim
    slack
    thunderbird
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Setting iterm2 profile..."
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "Setting emacs as editor..."
export EDITOR="emacsclient"

echo "Brew cleanup..."
brew cleanup
