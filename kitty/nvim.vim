" Start kitty scrollback pager specific ---------------------------------------
set nonumber
set scrollback=100000
set laststatus=0
set ignorecase

map <silent> q :qa!<CR>

" Short highlight on yanked text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup start_at_bottom
    autocmd!
    autocmd VimEnter * normal G
augroup END

augroup prevent_insert
    autocmd!
    autocmd TermEnter * stopinsert
augroup END

" improve compatibility with powline icons
set ambiwidth=single
" turn off tabline of airline
call airline#extensions#tabline#autoshow#off()
" turn off trailing wihitespace
let g:better_whitespace_enabled = 0
silent execute '%s/\n\+\%$//e'
silent execute '%s/\s\+\%$//e'
let line_below_last_line=line('$') + 1
silent write! /tmp/kitty_scrollback_buffer
silent execute "bd! /tmp/kitty_scrollback_buffer"
te cat /tmp/kitty_scrollback_buffer -
call feedkeys(":" . line_below_last_line . "\n")
" End kitty scrollback pager specific -----------------------------------------
