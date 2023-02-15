" Start kitty scrollback paper specific ---------------------------------------
set relativenumber
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

call airline#extensions#tabline#autoshow#off()
" End kitty scrollback paper specific -----------------------------------------
