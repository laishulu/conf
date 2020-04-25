#!/bin/sh
# PATH will later be reordered in /etc/zprofile that calls /usr/libexec/path_helper
LANG="en_US.UTF-8"
LANGUAGE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

if [ -e "$HOME/.brew.zsh" ]; then
	. "$HOME/.brew.zsh"
	export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin":$PATH
	export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin":$PATH
	export PATH="$BREW_PREFIX/opt/python/libexec/bin":$PATH
	export MANPATH="$BREW_PREFIX/share/man":$MANPATH
	export MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnuman":$MANPATH

	# for brewed openssl
	export LDFLAGS="-L$BREW_PREFIX/opt/openssl/lib"
	export CPPFLAGS="-I$BREW_PREFIX/opt/openssl/include"

	export FZF_BASE="$BREW_PREFIX/opt/fzf"
fi

if [ -e "$HOME/.emacs.d/bin" ]; then
	export PATH="$HOME/.emacs.d/bin":$PATH
fi

# rust
export CARGO_HOME="$HOME/.cargo"
if
	hash rustup >/dev/null 2>&1
then
	RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
	export RUST_SRC_PATH
fi
export RUST_BACKTRACE=1
export PATH="$CARGO_HOME/bin":$PATH

# haskell
export PATH="$HOME/.local/bin":$PATH

export PATH="$HOME/bin":$PATH

# 10ms for key sequences,
# default 400ms cause latency when entering vi normal mode
KEYTIMEOUT=1
export KEYTIMEOUT

test -e "$HOME/.site/profile.zsh" && . "$HOME/.site/profile.zsh"

# remove redundant path
uniq_path() {
	if [ -n "$PATH" ]; then
		old_PATH=$PATH
		PATH=""
		while [ -n "$old_PATH" ]; do
			x=${old_PATH%%:*} # the first remaining entry
			case $PATH: in
			*:"$x":*) ;;        # already there
			*) PATH=$PATH:$x ;; # not there yet
			esac
			old_PATH=${old_PATH#*:}
		done
		PATH=${PATH#:}
		unset old_PATH x
	fi
}

uniq_path
