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

" strip end of the buffer
silent execute '%s/\n\+\%$//e'
silent execute '%s/\s\+\%$//e'
let s:line_for_cursor=line('$')

" fix wrong rendering background of the last line
let s:prev_line_num = prevnonblank(line('$') - 1)
call setline(s:prev_line_num, getline(s:prev_line_num)  . "\33[49m")

silent write! /tmp/kitty_scrollback_buffer
silent execute "bd! /tmp/kitty_scrollback_buffer"
" if w/o additional file (stdin: -), "[Process exited 0]" will show.
terminal cat /tmp/kitty_scrollback_buffer -

function! s:show_history(...)
    normal! G
    sleep 100m
    call cursor(s:line_for_cursor, 1)
    " or airline will always take effect even statusline is set below
    let w:airline_disable_statusline = 1
    set laststatus=2
    set statusline=----------\ History\ [-%{line('$')-line('.')},\ %L]\ ----------
endfunction

" Wait for cat to output everything
let check_finish =
            \"while pgrep -f 'cat /tmp/kitty_scrollback_buffer' > /dev/null;"
            \"do" .
            \"    sleep 0.01;" .
            \"done" .
let job_id = jobstart(
            \"sh -c" . " " . check_finish,
            \{'on_exit' : function('s:show_history')})
" End kitty scrollback pager specific -----------------------------------------
