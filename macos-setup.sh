#!/usr/bin/env bash
set -euo pipefail

echo "dotfile installer"
echo "--------------------"
echo
export DOTFILES_PATH="$HOME/.dotfiles"
echo "Cloning into: '$DOTFILES_PATH'"

# To test that git is installed (if not macOS will prompt an installer)
git --version

git clone --depth 1 git@github.com:mgijon/dotfiles.git "$DOTFILES_PATH"

if [ -x "$DOTFILES_PATH/bin/dot" ]; then
    "$DOTFILES_PATH/bin/dot" self install
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# C / C++ compilers
# Xcode Command Line Tools provide clang/clang++ (required by Homebrew anyway)
xcode-select --install 2>/dev/null || true
# Latest GCC via Homebrew (gcc formula tracks the newest stable release)
brew install gcc

# Python
brew install python
# PyCharm
brew install --cask pycharm
# R
brew install --cask r
# R Studio
brew install --cask rstudio
# Docker
brew install --cask docker
# FZF
brew install fzf
brew upgrade fzf
# Ghostty
brew install --cask ghostty
# TMux
brew install tmux

# tmuxifier
TMUXIFIER_DIR="$HOME/.tmuxifier"
if [ ! -d "$TMUXIFIER_DIR" ]; then
    git clone https://github.com/jimeh/tmuxifier.git "$TMUXIFIER_DIR"
else
    echo "[WARN]  tmuxifier already present at $TMUXIFIER_DIR"
fi

SHELL_RC="$HOME/.zshrc"
if ! grep -q 'tmuxifier' "$SHELL_RC" 2>/dev/null; then
    cat >> "$SHELL_RC" <<'EOF'

# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
EOF
fi

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

# Conda (miniconda)
brew install --cask miniconda

## Install Vundle - VIM plugin manager
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Fastfetch
brew install fastfetch

# TODO: pass password to install plugings



# Install recursive grep
brew install ripgrep
# If it does not work, I've already use in the past the installation using cargo: $ cargo install ripgrep
brew install typst

