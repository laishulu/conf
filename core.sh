#!/usr/bin/env bash

if
	type "brew" >/dev/null 2>&1
then
	brew install zsh fasd tmux neovim
	brew install cmake shfmt

	# command line productivity
	brew install tree fzf bat ripgrep fd piknik

	# required by many tools
	brew install socat
fi
