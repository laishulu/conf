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
# piknik yank to system clipboard
local copy_to_clipboard=$(source ~/.tmux/plugins/tmux-yank/scripts/helpers.sh && clipboard_copy_command)
local copy_to_clipboard_without_newline="tr -d '\\n' | $copy_to_clipboard"
alias pky="piknik -paste | $copy_to_clipboard_without_newline"
