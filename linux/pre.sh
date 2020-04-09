#!/usr/bin/env bash

if [[ (! -d /home/linuxbrew/.linuxbrew) && $donot_install_software != "yes" ]]; then
	echo "installing brew"
	# suppress confirmation
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)" <<EOF







EOF
	echo "brew installed"
fi

if [[ -d ~/.linuxbrew ]]; then
	export PATH="~/.linuxbrew/bin:~/.linuxbrew/sbin:$PATH"
	export BREW_PREFIX="$(brew --prefix)"
	echo "alias brew=~/.linuxbrew/bin/brew" >~/.brew.zsh
	echo "export BREW_PREFIX='$BREW_PREFIX'" >>~/.brew.zsh
elif [[ -d /home/linuxbrew/.linuxbrew ]]; then
	# note: run brew by root is forbidden
	export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
	export BREW_PREFIX="/home/linuxbrew/.linuxbrew"
	echo "alias brew=/home/linuxbrew/.linuxbrew/bin/brew" >~/.brew.zsh
	echo "export BREW_PREFIX='$BREW_PREFIX'" >>~/.brew.zsh
	function brew() {
		[[ $donot_install_software == "yes" ]] || command brew "$@"
	}
fi
