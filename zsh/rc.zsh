# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#==============================================
# environment
#==============================================
source $HOME/.zsh/profile.sh

# user customized pre script
test -e $HOME/.site/pre.zsh && source $HOME/.site/pre.zsh

ZSH_DISABLE_COMPFIX=true
#==============================================
# plugins
#==============================================
# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
  echo "Creating a zgen save"

  zgen oh-my-zsh

  zgen load "romkatv/powerlevel10k" "powerlevel10k"
  zgen load "zdharma/fast-syntax-highlighting"
  zgen load "zsh-users/zsh-history-substring-search"
  zgen load "zsh-users/zsh-completions"
  zgen load "zsh-users/zsh-autosuggestions"
  zgen load "psprint/zsh-navigation-tools"
  zgen load "skywind3000/z.lua"

  zgen oh-my-zsh "plugins/vi-mode"
  zgen oh-my-zsh "plugins/tmux"
  zgen oh-my-zsh "plugins/command-not-found"
  zgen oh-my-zsh "plugins/colored-man-pages"
  zgen oh-my-zsh "plugins/extract"
  zgen oh-my-zsh "plugins/ripgrep"

  if hash fzf >/dev/null 2>&1; then
    zgen oh-my-zsh "plugins/fzf"
    zgen oh-my-zsh "plugins/zsh-interactive-cd"
    # run `build-fzf-tab-module` to speedup
    zgen load "Aloxaf/fzf-tab"
  fi

  if [[ `uname` == 'Darwin' ]]; then
    zgen oh-my-zsh "plugins/osx"
    zgen load "kutsan/zsh-system-clipboard"
  fi

  zgen load "spwhitt/nix-zsh-completions"
  zgen load "chisui/zsh-nix-shell"

  zgen oh-my-zsh "plugins/git"
  zgen oh-my-zsh "plugins/gitignore"
  zgen oh-my-zsh "plugins/git-flow-avh"

  zgen oh-my-zsh "plugins/python"
  zgen oh-my-zsh "plugins/pip"
  zgen oh-my-zsh "plugins/pipenv"

  zgen oh-my-zsh "plugins/node"
  zgen oh-my-zsh "plugins/npm"

  zgen oh-my-zsh "plugins/rust"
  zgen oh-my-zsh "plugins/cargo"

  if type "rustup" >/dev/null 2>&1;then
  zgen oh-my-zsh "plugins/stack"
  fi
  zgen oh-my-zsh "plugins/docker"

  test -e $HOME/.site/plugins.zsh && source $HOME/.site/plugins.zsh
  # save all to init script
  zgen save
fi

#==============================================
# config zsh and plugins
#==============================================
# colored completion - use my LS_COLORS
eval `dircolors ~/.config/dircolors/LS_COLORS`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# }}}

# for zsh-history-substring-search {{{
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
setopt HIST_IGNORE_ALL_DUPS
# }}}

# for autosuggestions {{{
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=13"
# (e)xecute
bindkey '^e' autosuggest-execute
# (s)top suggest
bindkey '^s' autosuggest-clear
# move (f)orword
bindkey '^f' autosuggest-accept
# }}}

# fzf {{{
if hash sk >/dev/null 2>&1; then
    export SKIM_DEFAULT_COMMAND="fd || git ls-tree -r --name-only HEAD || find ."
    alias fzf="sk"
fi

if hash fzf >/dev/null 2>&1; then
    fzf-history-widget-accept() {
        fzf-history-widget
        zle accept-line
    }
    zle     -N     fzf-history-widget-accept
    bindkey '^X' fzf-history-widget-accept
fi

# find in file
ff() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
# }}}

# disable bracketed paste in tmux {{{
if [ ${TMUX} ]; then
  # unset zle_bracketed_paste
fi
# }}}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fpath=($HOME/.site/zfunctions $fpath)

# direnv
hash direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

source $HOME/.zsh/aliases.zsh

# user customized post script
test -e $HOME/.site/post.zsh && source $HOME/.site/post.zsh || true

# load auto complete
autoload -Uz compinit
compinit
