#!/usr/bin/env bash

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)

if [[ $overwrite == "yes" || ! -e ~/.emacs.d ]]; then
	git clone -b develop https://github.com/hlissner/doom-emacs ~/.emacs.d
	mkdir -p ~/.config
	ln -sfn $root_dir/emacs/doom ~/.config/doom
	~/.emacs.d/bin/doom install
fi
