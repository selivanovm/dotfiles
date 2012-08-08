#!/bin/bash

# Prompt for sudo credentials
echo "Give sudo credentials for later, please."
sudo echo ""

# Make sure the room is clean
rm -R ~/.emacs*
rm -R ~/.bash*

# Link the configuration files
ln -s `pwd`/.emacs* ~/
ln -s `pwd`/.zshrc ~/
ln -s `pwd`/.bash_profile ~/
ln -s `pwd`/hg/.* ~/
ln -s `pwd`/.git* ~/
ln -s `pwd`/vim/.* ~/

# Install Zsh
sudo chsh -s /bin/zsh thomas
mkdir ~/code/dotfiles/oh-my-zsh/custom
touch ~/code/dotfiles/oh-my-zsh/custom/placeholder.zsh

# Install the Dulwich Python library for Hg-Git
sudo easy_install-2.7 dulwich

# Fix the Molokai versioned link for Emacs
rm ~/.emacs.d/themes/molokai-theme.el
hg clone ssh://hg@bitbucket.org/pelletier/color-theme-molokai ~/code/color-theme-molokai
ln -s ~/code/color-theme-molokai/molokai-theme.el ~/.emacs.d/themes/

# Install Vagrant
sudo gem install --no-rdoc --no-ri vagrant
