#!/usr/bin/env bash

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)

brew tap d12frosted/emacs-plus
brew install emacs-plus

# needed by vterm of emacs
brew install cmake libvterm
brew install editorconfig gnu-indent global

source $root_dir/emacs/config.sh
