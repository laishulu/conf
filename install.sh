#!/usr/bin/env bash

if [[ $(uname) == 'Linux' ]]; then
	if [[ ! -d ~/.linuxbrew && -d /home/linuxbrew/.linuxbrew && ! -v donot_install_software ]]; then
		echo -n "Do you want to use system brew? (yes/no):"
		read donot_install_software
	fi
fi

if [[ ! -v overwrite ]]; then
	echo -n "Do you want to overwrite existing configs? (no/yes):"
	read overwrite
fi

if [[ $(uname) == 'Darwin' ]]; then
	if [[ $overwrite == "yes" && ! -v macos_keymap ]]; then
		echo -n "Do you **REALLY** want to switch <ESC> and <CAPS LOCK> ???(no/switch):"
		read macos_keymap
	fi
fi

if [[ $config_keymap ]]; then
	if [[ $config_keymap != "switch" ]]; then
		echo "Invalid setting <config_keymap> to '$config_keymap'"
	fi
fi

if [[ $donot_install_software != "yes" ]]; then

	if [[ ! -v install_dev ]]; then
		echo -n "Do you want to install extra tools? (no/yes):"
		read install_extra
	fi

	if [[ ! -v install_dev ]]; then
		echo -n "Do you want to write codes? (no/yes):"
		read install_dev
	fi

	if [[ $install_dev == "yes" && ! -v install_emacs ]]; then
		echo -n "Do you want to install emacs? (no/yes):"
		read install_emacs
	fi

	if [[ $install_dev == "yes" && ! -v install_py_dev ]]; then
		echo -n "Do you want to write python3 codes? (no/yes):"
		read install_py_dev
	fi

	if [[ $install_dev == "yes" && ! -v install_rs_dev ]]; then
		echo -n "Do you want to write rust codes? (no/yes):"
		read install_rs_dev
	fi

	if [[ $install_dev == "yes" && ! -v install_hs_dev ]]; then
		echo -n "Do you want to write haskell codes? (no/yes):"
		read install_hs_dev
	fi

	if [[ $install_dev == "yes" && ! -v install_js_dev ]]; then
		echo -n "Do you want to write javascript codes? (no/yes):"
		read install_js_dev
	fi

	if [[ $install_dev == "yes" && ! -v install_c_dev ]]; then
		echo -n "Do you want to write clang codes? (no/yes):"
		read install_c_dev
	fi
fi

if [[ $(uname) == 'Linux' ]]; then
	source ./linux/pre.sh
elif [[ $(uname) == 'Darwin' ]]; then
	source ./macos/pre.sh
fi

if [[ $donot_install_software != "yes" ]]; then
	source ./core.sh
fi

if [[ $(uname) == 'Linux' ]]; then
	source ./linux/post.sh
elif [[ $(uname) == 'Darwin' ]]; then
	source ./macos/post.sh
fi

if [[ $install_extra == "yes" ]]; then
	source ./extra.sh
fi

if [[ $install_dev == "yes" ]]; then
	source ./dev.sh
fi

# common config
source ./config.sh

if [[ $(uname) == 'Darwin' && -e ./macos/optional/config.sh ]]; then
	source $script_dir/macos/optional/config.sh
fi
