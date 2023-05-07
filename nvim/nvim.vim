source ~/.config/nvim/rc/pre.vim

if !empty(glob("~/.site/pre.vim"))
  source ~/.site/pre.vim
endif

" Start dein Scripts----------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let $CACHE = expand('~/.local/share/')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

" Required:
if dein#load_state('~/.config/nvim/bundle')
  call dein#begin('~/.config/nvim/bundle')

  " Let dein manage dein
  " Required:
  call dein#add('~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim')

  call dein#load_toml('~/.config/nvim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/rc/deinlazy.toml', {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

call dein#call_hook('post_source')
" End dein Scripts-------------------------------------------------------------


" Start host and providers-----------------------------------------------------
let g:python_host_prog = ChompedSystem('brew --prefix') . '/bin/python'
let g:python3_host_prog = ChompedSystem('brew --prefix') . '/bin/python3'

" disable legacy provider
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
" End host and providers-------------------------------------------------------


source ~/.config/nvim/rc/post.vim

if !empty(glob("~/.site/post.vim"))
  source ~/.site/post.vim
endif
