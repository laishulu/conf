filetype plugin indent on
syntax enable

set shiftwidth=4
set softtabstop=4
set breakindent

set number
set colorcolumn=80

" ignored when expanding wildcards, completing file or directory names
set wildignore=*.o,*.obj,*.la,*.lo,*.so,*.pyc,*.pyo,*.jpg,*.png,*.gif
" always use short message, to reduce: Press ENTER or type command to continue
set shortmess=aoOtI

set clipboard+=unnamed,unnamedplus

" move cursor among wrapped lines as normal
noremap j gj
noremap k gk
" use <space> as leader instead of the default `\`
map <Space> <Leader>
nnoremap <Leader>w <C-W>
nnoremap <Leader>q :<C-u>close<CR>
nnoremap <Leader>a :<C-u>e#<CR>

" Start enable syntax highlight in `bufdo` command ----------------------------
" note checktime/autoread would not work fo git(vim-fugitive) mark
" Enable syntax highlighting when buffers were loaded through :bufdo, which
" disables the Syntax autocmd event to speed up processing.
augroup EnableSyntaxHighlighting
  " Filetype processing does happen, so we can detect a buffer initially
  " loaded during :bufdo through a set filetype, but missing b:current_syntax.
  " Also don't do this when the user explicitly turned off syntax highlighting
  " via :syntax off.
  " Note: Must allow nesting of autocmds so that the :syntax enable triggers
  " the ColorScheme event. Otherwise, some highlighting groups may not be
  " restored properly.
  autocmd! BufWinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') && ! empty(&l:filetype) | syntax enable | endif

  " The above does not handle reloading via :bufdo edit!, because the
  " b:current_syntax variable is not cleared by that. During the :bufdo,
  " 'eventignore' contains "Syntax", so this can be used to detect this
  " situation when the file is re-read into the buffer. Due to the
  " 'eventignore', an immediate :syntax enable is ignored, but by clearing
  " b:current_syntax, the above handler will do this when the reloaded buffer
  " is displayed in a window again.
  autocmd! BufRead * if exists('syntax_on') && exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') != -1 | unlet! b:current_syntax | endif
augroup END
" End enable syntax highlight in `bufdo` command ------------------------------


" Start visual interaction ----------------------------------------------------
" mouse support
if has("mouse_sgr")
    set ttymouse=sgr
elseif has("mouse_xterm")
    set ttymouse=xterm2
endif

if has("mouse")
  set mouse+=a
endif

" start use visual bell to disable beep, and then disable visual bell
set noerrorbells visualbell t_vb=
augroup disable_visualbell
  autocmd!
  autocmd GUIEnter * set visualbell t_vb=
augroup END
" End visual interaction ------------------------------------------------------


" Start locale/encoding support -----------------------------------------------
if has("multi_byte") "{{{
  set encoding=utf-8
  set fencs=ucs-bom,utf-8,gbk,cp936,latin1
  set formatoptions+=mM
  set nobomb

  if get(g:, 'ambi_double', 1)
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
      set ambiwidth=double
    endif
  else
      set ambiwidth=single
  endif
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif "}}}
" End locale/encoding support -------------------------------------------------


" Start custom command (prefixed by `Me`) -------------------------------------
" Capitalize first letter of each word in a selection
command! -range MeTitle s/\<./\u&/g
command! MeUpdate call s:update_plugins()
function! s:update_plugins()
  call dein#update()
  UpdateRemotePlugins
endfunction
" End custom command ----------------------------------------------------------
