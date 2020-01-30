#!/usr/bin/env bash

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
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git

echo "Git config"
read -p "Enter user.name:" name
read -p "Enter user.email:" email

git config --global user.name "$name"
git config --global user.email $email

echo "Installing brew stuff..."
brew install gnupg
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install python
brew install caskroom/cask/brew-cask

echo "Installing dotfiles..."
./dotfiles_install.sh

echo "Installing zsh and setting as shell..."
brew install zsh
chsh -s $(which zsh)

apps=(
    chrome
    thunderbird
    emacs
    iterm2
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Brew cleanup..."
brew cask cleanup
brew cleanup
