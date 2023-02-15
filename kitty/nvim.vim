" Start kitty scrollback paper specific ---------------------------------------
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
" turn off trailing wihitespace warning of vim-better-whitespace
let g:better_whitespace_enabled = 0
" End kitty scrollback paper specific -----------------------------------------