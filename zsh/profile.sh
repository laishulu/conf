#!/bin/sh
# PATH will later be reordered in /etc/zprofile that calls /usr/libexec/path_helper
# thus this file should be called again in .zshrc
LANG="en_US.UTF-8"
LANGUAGE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

if [ -e "$HOME/.brew.zsh" ]; then
	# shellcheck source=/dev/null
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

# shellcheck source=/dev/null
test -e "$HOME/.site/profile.sh" && . "$HOME/.site/profile.sh"

# remove redundant path
uniq_path() {
	__path_name=$1
	__path_value=
	eval "__path_value=\"\${$__path_name}\""
	if [ -n "$__path_name" ]; then
		__old_path=$__path_value:
		__new_path=
		while [ -n "$__old_path" ]; do
			__x=${__old_path%%:*} # the first remaining entry
			case $__new_path: in
			*:"$__x":*) ;;                    # already there
			*) __new_path=$__new_path:$__x ;; # not there yet
			esac
			__old_path=${__old_path#*:}
		done
		__new_path=${__new_path#:}
		eval "$__path_name=\"$__new_path\""
		unset __old_path __new_path x
	fi
	unset __path_name
}

uniq_path PATH
uniq_path MANPATH
