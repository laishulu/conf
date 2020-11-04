function ls() {
	command ls --color "$@" 2>/dev/null || command ls "$@"
}

alias lll="ls -1"

alias gf="git flow"

function UpdateZsh() {
	if [[ -z "${CONF_DIR}" ]]; then
		if [[ -f "~/conf/zsh/aliases.zsh" ]]; then
			export CONF_DIR="~/conf"
		else
			echo "<CONF_DIR> environment variable is not defined"
		fi
	else
		alias UpdateConf="pushd ${CONF_DIR} && git pull -f ./ && popd"
	fi
	zgen update && zgen selfupdate
}
alias UpdateEmacs="~/.emacs.d/bin/doom upgrade"
alias UpdateNvim="nvim -E -c 'MeUpdate' -c 'q'"
alias UpdateTmux="~/.tmux/plugins/tpm/bin/update_plugins all"

alias tmux="tmux -u"

alias bat="bat --theme TwoDark"
alias preview="fzf --preview 'bat --color \"always\" {}'"

alias vv='nvim'
alias cleanvim="find ./ -name '.*.swp'|xargs rm -v"
export EDITOR="nvim"
export VISUAL="nvim"

EC="emacsclient -nw -create-frame --alternate-editor=''"
alias ee="emacs -nw"
alias ec="$EC"
alias ke="emacsclient -e '(kill-emacs)'"

source $BREW_PREFIX/etc/profile.d/piknik.sh
# piknik tmux copy
alias pktc="tmux save-buffer - | piknik -copy"
# piknik tmux paste
alias pktp="piknik -paste | tmux load-buffer -"

if [[ `uname` == 'Darwin' ]]; then
	clipboard_cp_cmd() {
		# installing reattach-to-user-namespace is recommended on OS X
		if command_exists "pbcopy"; then
			if command_exists "reattach-to-user-namespace"; then
				echo "reattach-to-user-namespace pbcopy"
			else
				echo "pbcopy"
			fi
		fi
	}

	# piknik yank to system clipboard
	local cp_to_clipboard=$(clipboard_cp_cmd)
	local cp_to_clipboard_no_newline="tr -d '\\n' | $cp_to_clipboard"
	alias pky="piknik -paste | $copy_to_clipboard_no_newline"
fi
