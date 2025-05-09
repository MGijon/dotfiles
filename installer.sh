#!/usr/bin/env bash
set -euo pepefail

echo "dotfile installer"
echo "--------------------"
echo
export DOTFILE_PATH="$HOME/.dotfiles"
echo "Cloning into: '$DOTFILES_PATH'"

# To test that git is installed (if not macOS will prompt an installer)
git --version

git clone --depth 1 git#github.com:mgijon/dotfiles.git "$DOTFILES_PATH"

"$DOTFILES_PATH/bin/dot" self install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Python
brew install python
# PyCharm
brew install --cask pycharm
# R
 brew install --cask r #brew install r
# R Studio
brew install --cask rstudio
# Docker
brew install docker
# FZF
brew install fzf
brew upgrade fzf
# Ghostty
brew install --cask ghostty
# TMux
brew install tmux

# Graphviz
brew install graphviz
# Postgres
brew install postgresql
# Data Version Control
brew install dvc
# Julia
# curl -fsSL https://install.julialang.org | sh

# Firefox
brew install --cask firefox
# Google Chrome
brew install --cask google-chrome
# Thunderbird
brew install --cask thunderbird
# Telegram
brew install --cask telegram
# Discord
brew install --cask discord
# Skype
brew install --cask skype
# Slack
brew install --cask slack
# Obs Stream
brew install --cask obs

# Dropbox
brew install --cask dropbox
# Kindle
brew install --cask kindle
# Notion
brew install --cask notion

# Atom
brew install --cask atom
# Visual Studio Code
brew install --cask visual-studio-code

# Deezer
brew install --cask deezer
# Postman
brew install --cask postman
# Musescore
brew install --cask musescore

#
brew install gpg pinentry-mac
# Mactex
brew install --cask mactex

# Conda
brew install conda

## Install Vundle - VIM plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Fastfetch
brew install fastfetch

# TODO: pass password to install plugings



# Install recursive grep
brew install ripgrep
# If it does not work, I've already use in the past the installation using cargo: $ cargo install ripgrep
