#!/usr/bin/env zsh

# get the dir of the current script
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ "$(uname)" == "Linux" ]; then
	if [ ! -d "$HOME/.linuxbrew" ] && [ -d /home/linuxbrew/.linuxbrew ] && [ ! -v donot_install_software ]; then
		echo -n "Do you want to use system brew? (yes/no):"
		read -r donot_install_software
	fi
fi

if ! [ -v overwrite ]; then
	echo -n "Do you want to overwrite existing configs? (no/yes):"
	read -r overwrite
fi

if [ "$(uname)" == 'Darwin' ]; then
	if [ "$overwrite" == "yes" ] && [ ! -v macos_keymap ]; then
		echo -n "Do you **REALLY** want to switch <ESC> and <CAPS LOCK> ???(no/switch):"
		read -r macos_keymap
	fi
fi

if [ -v config_keymap ]; then
	if [ "$config_keymap" != "switch" ]; then
		echo "Invalid setting <config_keymap> to '$config_keymap'"
	fi
fi

if [ "$donot_install_software" != "yes" ]; then

	if ! [ -v install_dev ]; then
		echo -n "Do you want to install extra tools? (no/yes):"
		read -r install_extra
	fi

	if ! [ -v install_dev ]; then
		echo -n "Do you want to write codes? (no/yes):"
		read -r install_dev
	fi

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
fi

if [ "$(uname)" == 'Linux' ]; then
	source "$script_dir/linux/pre.sh"
elif [ "$(uname)" == 'Darwin' ]; then
	source "$script_dir/macos/pre.sh"
fi

if [ "$donot_install_software" != "yes" ]; then
	source "$script_dir/core.sh"
fi

if [ "$(uname)" == 'Linux' ]; then
	source "$script_dir/linux/post.sh"
elif [ "$(uname)" == 'Darwin' ]; then
	source "$script_dir/macos/post.sh"
fi

if [ "$install_extra" == "yes" ]; then
	source "$script_dir/extra.sh"
fi

if [ "$install_dev" == "yes" ]; then
	source "$script_dir/dev.sh"
fi

# common config
source "$script_dir/config.sh"

if [ "$(uname)" == 'Darwin' ] && [ -e "$script_dir/macos/optional/config.sh" ]; then
	# shellcheck source=./macos/optional/config.sh
	source "$script_dir/macos/optional/config.sh"
fi
