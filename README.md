## About

Shell envrionment configuration. Compatible with MacOS and Linux.

I shifted from `nvim` to `emacs/evil`, the later is just like a better `nvim`.

- `emacs/evil` is not installed by default, but it's actively maintained,
  especially recommended for heavy editing. `emacs` is aliased to `ee`
- `nvim` is installed by default, but it's greatly stripped down for light
  editing, also not actively maintained. `nvim` is aliased to `vv`

## Preparation

### Linux

For Linux, `build-essential curl file git` is required.
If you want to install extra tools,
significant time could be saved if `cargo` and `golang` is avaiable already.

`linuxbrew` is utilized to manage softwares.

- `root` user can't install it, but can instead use brew installed system widely.
- unprivileged user can install in his own directory.
- `sudo` users can install system widely. `NOPASSWD` priviledge is required by
  this config additionally.

If you don't want to install softwares, or softwares are already available, you
should set environment variable `donot_install_software=true` before install.

In _Debian_ linux, if you want to install software from _apt_ in favor of
_brew_, you should run the following commands during install.

```
make apt
donot_install_software=true make install
```

- It's recommended to create a dedicated user (e.g. `soft`) to install system
  wide brew.
  - `adduser soft sudo`
  - run `visudo`, and ensure `%sudo   ALL=(ALL:ALL) NOPASSWD:ALL`
  - `su - soft`

### Macos

For MacOS, `xcode` should be installed first.

## Install

```
cd
git clone https://github.com/laishulu/conf.git <SOME_DIR>
cd <SOME_DIR>
make install
# for more choice, run the following
make
```

To display ZSH prompt properly, you should also install font of
[Sarasa-Term-SC-Nerd](https://github.com/laishulu/Sarasa-Term-SC-Nerd),
and set it as your terminal fonts.

For MacOS, _kitty_ will also be installed and preconfigured with this font, so
you can use _kitty_ as your terminal directly without hassle.

## Cusomization

- zsh:
  - pre config: `~/.site/pre.zsh`
  - post config: `~/.site/post.zsh`
  - plugins: `~/.site/plugins.zsh`
  - autocomplete: `~/.site/zfunctions`
- tmux: `~/.site/tmux.conf`
- emacs: `~/.site/init.el`
- nvim:
  - pre config: `~/.site/pre.vim`
  - post config: `~/.site/post.vim`

## Update configs and plugins

- conf: `UpdateConf`
- zsh: `UpdateZsh`
- tmux: `UpdateTmux`
- emacs: `UpdateEmacs`
- nvim: `UpdateNvim`

## Important Productivity Tools

- use `z` to `cd` fuzzily
- use `rg` instead of `grep`
- use `fd` instead of `find` (not avaiable in linux by default)
- use `bat` instead of `cat/more/less` to view source file
- `ga/gc/gp/gl` for `git add/commit/push/pull`, `tig` for `git log`
- ssh
  - use `storm` to manage your `ssh` connections.
  - use `ssh-copy-id` to copy public key to remote server, so you can ssh login
    with key.
  - use `sshfs` to mount remote directory to local for editing.
- mouse
  - select text in tmux. When mouse is released, text will be copied into
    clipboard.
  - select text in vim.
  - drag border will resize windows for emacs/nvim/tmux

## Important Key Maps

- macos: if you runned `make mac-optional` after `make install`, then
  `<capslock>` is switched with `<esc>` by _karabiner_.
- kitty
  - `<Command + t>`: new tab
  - `<Command + w>`: close tab
  - `<Command + n>`: next tab
  - `<Command + p>`: previous tab
  - `<Command + b>`: scrollback history
- tmux prefix key
  - macos: `ctrl+a`. Press `ctrl+a` `ctrl+a` to pass through `ctrl+a`
  - linux: `ctrl+b`. Press `ctrl+b` `ctrl+b` to pass through `ctrl+b`
- tmux
  - `<prefix> c`: create new window
  - `<prefix> number`: select window
  - `<prefix> p/n`: select previous/next window
  - `<prefix> z`: zoom window
  - `<prefix> [`: copy mode
    - `v`: visual select text
    - `y/enter`: yank text to clipboard. In remote linux, text will also be
      piped to local.
  - `<prefix> s`: split horizentally
  - `<prefix> v`: verticaly split
  - `<prefix> d`: detach tmux
  - `<prefix> x`: kill window
  - `<prefix><ctrl+s>`: save envrionment
  - `<prefix><ctrl+r>`: restore envrionment
- tmux/emacs/nvim pane navigation: `ctrl+h/l/j/k`
- zsh:
  - `<esc>`: vi mode
    - `j/k`: history search up/down with existing text
    - `/`: search history by pattern
    - `v`: edit in $EDITOR
  - `<ctrl+e>`: execute auto suggest
  - `<ctrl+s>`: sweep away auto suggest
  - `<ctrl+f>`: foward accept auto suggest
  - `<ctrl+x>`: fzf fuzzy search commannd and execute
  - `<ctrl+r>`: fzf fuzzy search commannd and paste
  - `<ctrl+t>`: fzf fuzzy search files and paste
  - `<alt+c>`: fzf cd into the selected directory
  - `**<tab>`: fzf fuzzy complete
