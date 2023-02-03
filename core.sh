#!/usr/bin/env bash

if
	type "brew" >/dev/null 2>&1
then
  brew install vivid
	brew install zsh lua tmux neovim direnv
	brew install cmake shfmt shellcheck tig

	# command line productivity
	brew install tree fzf bat ripgrep fd piknik
fi
