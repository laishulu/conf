#!/usr/bin/env bash

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)

if [[ $(uname) == 'Darwin' ]]; then
	brew tap d12frosted/emacs-plus
	brew install emacs-plus
	brew tap laishulu/macism
	brew install macism
fi

# needed by vterm of emacs
brew install cmake libvterm
brew install editorconfig gnu-indent global

source "$root_dir/emacs/config.sh"
