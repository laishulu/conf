#!/usr/bin/env bash

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && cd .. && pwd)

if [[ $overwrite == "yes" ]]; then
	open "$root_dir/macos/optional/One-Dark.terminal"
fi

if [[ $macos_keymap = "switch" ]]; then
	brew cask install karabiner-elements
	if ! [[ -e ~/.config/karabiner/karabiner.json ]]; then
		mkdir -p ~/.config/karabiner
		ln -sf $root_dir/macos/optional/karabiner.json ~/.config/karabiner/karabiner.json
	fi
fi
