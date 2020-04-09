let mapleader = ' '

" set ambiguous char to have single width,
" so you can use special char in lightline.
" some times it's useful to have double width for zh/ja/ko lanuage
"
if has("gui") || $TERM_PROGRAM ==# 'iTerm.app'
  let g:ambi_double = 0
else
  let g:ambi_double = 1
endif
