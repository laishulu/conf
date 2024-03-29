#!/usr/bin/env bash

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# install git tools
brew install git git-flow-avh tig

# install develop tools
brew install direnv

# install tools
brew install openssl

install_dev="yes"

if [ "$install_dev" == "yes" ] && [ ! -v install_emacs ]; then
	echo -n "Do you want to install emacs? (no/yes):"
	read -r install_emacs
fi

if [ "$install_dev" == "yes" ] && [ ! -v install_py_dev ]; then
	echo -n "Do you want to write python3 codes? (no/yes):"
	read -r install_py_dev
fi

if [ "$install_dev" == "yes" ] && [ ! -v install_rs_dev ]; then
	echo -n "Do you want to write rust codes? (no/yes):"
	read -r install_rs_dev
fi

if [ "$install_dev" == "yes" ] && [ ! -v install_hs_dev ]; then
	echo -n "Do you want to write haskell codes? (no/yes):"
	read -r install_hs_dev
fi

if [ "$install_dev" == "yes" ] && [ ! -v install_js_dev ]; then
	echo -n "Do you want to write javascript codes? (no/yes):"
	read -r install_js_dev
fi

if [ "$install_dev" == "yes" ] && [ ! -v install_c_dev ]; then
	echo -n "Do you want to write clang codes? (no/yes):"
	read -r install_c_dev
fi

if [[ $install_emacs == "yes" ]]; then
	source $root_dir/emacs/install.sh
fi

if [[ $install_py_dev == "yes" ]]; then
	brew install python
	# use brewed tools such as pip
	export PATH=$BREW_PREFIX/opt/python/libexec/bin:$PATH
	pip install --upgrade pip pipenv setuptools wheel
	pip install --upgrade pyls-black
	# without pip, zsh auto completion would not work
	pip install --upgrade ipython
	pip install --upgrade 'python-language-server[rope,pyflakes,mccabe]'
	pip install --upgrade black
	pip install --upgrade flake8
fi

if [[ $install_rs_dev == "yes" ]]; then
	# rust
	if
		! type "rustup" >/dev/null 2>&1
	then
		echo "rust is not installed, now installing..."
		# for rust
		curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain stable -y
	fi

	PATH=$PATH:$HOME/.cargo/bin
	export CARGO_HOME=$HOME/.cargo

	rustup component add rust-src
	rustup component add rust-docs
	rustup component add rustfmt
	rustup component add clippy
	rustup component add rust-analyzer

	rustup install stable
	rustup default stable
	rustup update
	rustup self update

	# tools
	# for code completion
	cargo +nightly install --force racer
	# packages/misc
	cargo install --force cargo-count
	cargo install --force cargo-show
	cargo install --force cargo-update
	cargo install --force cargo-reinstall
fi

if [[ $install_hs_dev == "yes" ]]; then
	# For MacOS, if binutils is installed,
	# should `brew unlink binutils` first,
	# or it will cause problems.
	brew install haskell-stack cabal-install
	stack upgrade
	stack setup
	stack install hlint
	stack install hoogle
	stack install brittany
fi

if [[ $install_js_dev == "yes" ]]; then
	# for javascript
	brew install node
	npm install -g tern
fi

if [[ $install_c_dev == "yes" ]]; then
	brew install llvm
fi
