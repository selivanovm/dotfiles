#!/bin/bash

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
mkdir ~/code/dotfiles/oh-my-zsh/custom
touch ~/code/dotfiles/oh-my-zsh/custom/placeholder.zsh

# Fix the Molokai versioned link for Emacs
rm ~/.emacs.d/themes/molokai-theme.el
hg clone ssh://hg@bitbucket.org/pelletier/color-theme-molokai ~/code/color-theme-molokai
ln -s ~/code/color-theme-molokai/molokai-theme.el ~/.emacs.d/themes/
