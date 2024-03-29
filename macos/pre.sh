#!/usr/bin/env bash

# install brew and cask
if
	! type "brew" >/dev/null 2>&1
then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "export BREW_PREFIX='$(brew --prefix)'" >~/.brew.zsh

# use gnu version
brew install bash coreutils gnutls gnu-getopt gnu-tar gnu-sed gnu-which gnu-indent global
