#!/usr/bin/env bash
#
mkdir -p $HOME/.site/zfunctions
test -e $HOME/.zsh/profile.sh && source $HOME/.zsh/profile.sh

# get the dir of the current script
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [[ $overwrite && $SHELL != *zsh* ]]; then
	USER_ZSH=$(command -v zsh)

	if ! grep -q "$USER_ZSH" "/etc/shells"; then
		echo "Try adding $USER_ZSH to /etc/shells"
		sudo -v 2>&1 && echo "$USER_ZSH" | sudo tee -a /etc/shells
	fi

	if grep -q "zsh" "/etc/shells"; then
		if grep -q "$USER_ZSH" "/etc/shells"; then
			echo "Input your password to set zsh as your login shell"
			chsh -s "$USER_ZSH" $USER
		else
			echo "$USER_ZSH is not in /etc/shells, now use other available zsh"
			echo "Input your password to set zsh as your login shell"
			chsh -s "$(tac /etc/shells | grep -m 1 zsh)" $USER
		fi
	else
		echo "No zsh found in /etc/shells"
		echo "Now add zsh to your bash config"
		grep -q "$(command -v zsh)" && echo "$(command -v zsh)" >>~/.bashrc
	fi
fi

if [[ $overwrite == "yes" || ! -e ~/.zshrc ]]; then
	touch ~/.site/pre.zsh
	echo "export CONF_DIR='$script_dir'" >>~/.site/pre.zsh
	touch ~/.site/plugins.zsh
	touch ~/.site/post.zsh
	touch ~/.site/profile.sh
	ln -sf $script_dir/zsh/rc.zsh ~/.zshrc
	ln -sfn $script_dir/zsh ~/.zsh
	ln -sfn $script_dir/zsh/profile.sh ~/.profile
	if [[ `uname` == 'Darwin' ]]; then
		ln -sf $script_dir/zsh/p10k.macos.zsh ~/.p10k.zsh
	else
		ln -sf $script_dir/zsh/p10k.linux.zsh ~/.p10k.zsh
	fi
	# install package manager for zsh
	if [[ ! -d ~/.zgen/.git/ ]]; then
		rm -rvf ~/.zgen
		git clone https://github.com/tarjoilija/zgen.git ~/.zgen
	fi
	zgen update && zgen selfupdate
fi

if [[ $overwrite == "yes" || ! -e ~/.config/dircolors/LS_COLORS ]]; then
	mkdir -p ~/.config/dircolors
	ln -fs $script_dir/misc/LS_COLORS ~/.config/dircolors/
fi

if [[ $overwrite == "yes" || ! -e ~/.tmux.conf ]]; then
	mkdir -p ~/.config
	touch ~/.site/tmux.conf
	ln -sfn $script_dir/tmux ~/.config/
	ln -sf ~/.config/tmux/tmux.conf ~/.tmux.conf
	rm -rvf ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/bin/install_plugins
fi

if [[ $overwrite == "yes" ]]; then
	rm -rvf ~/.config/git
	ln -sfn $script_dir/git/configgit ~/.config/git
fi

if [[ $overwrite == "yes" || ! -e ~/.config/nvim/init.vim ]]; then
	touch ~/.site/pre.vim
	touch ~/.site/post.vim
	mkdir -p ~/.config/nvim/
	# for nvim
	ln -sfn $script_dir/nvim/nvim.vim ~/.config/nvim/init.vim
	ln -sfn $script_dir/nvim/rc ~/.config/nvim/rc

	# install package manager for nvim
	if [[ ! -d ~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim/.git/ ]]; then
		mkdir -p ~/.config/nvim/bundle/repos
		curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh >~/.config/nvim/bundle/installer.sh
		sh ~/.config/nvim/bundle/installer.sh ~/.config/nvim/bundle
	fi
fi

if [[ $overwrite == "yes" || ! -e ~/.inputrc ]]; then
	ln -sf $script_dir/misc/inputrc ~/.inputrc
fi

touch ~/.site/init.el

# -p says to create the dir if it doesn't exist already
mkdir -p $HOME/bin
