#!/usr/bin/env zsh

if
	type "brew" >/dev/null 2>&1
then
	brew install zsh lua tmux neovim direnv
	brew install cmake shfmt shellcheck tig

	# command line productivity
	brew install tree fzf sk skim bat ripgrep fd piknik

	# required by many tools
	brew install socat
fi
