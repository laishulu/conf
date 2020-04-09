let s:readonly_mark = 'RO'
let s:left_sep = ""
let s:right_sep = ""
let s:left_sub_sep = "|"
let s:right_sub_sep = "|"
let s:branch_mark = ""
let s:linecol_mark = ""

if !exists("g:ambi_double")
  let g:ambi_double = 0
endif

if !g:ambi_double
  let s:readonly_mark = "\ue0a2"
  let s:left_sep = "\ue0b0"
  let s:right_sep = "\ue0b2"
  let s:left_sub_sep = "\ue0b1"
  let s:right_sub_sep = "\ue0b3"
  let s:branch_mark = "\ue0a0"
  let s:linecol_mark = "\ue0a1"
endif

let g:lightline = {
      \ 'colorscheme': 'monokai_pro',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'component': {
      \'lineinfo': s:linecol_mark.'%l:%-1v',
      \'percent': '%p%%'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': s:left_sep, 'right': s:right_sep },
      \ 'subseparator': { 'left': s:left_sub_sep, 'right': s:right_sub_sep }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? s:readonly_mark : ''
endfunction

function! LightlineFilename()
  let fname = expand('%')
  return fname == '__Tagbar__' ? g:lightline.fname :
	\ fname =~ '__Gundo\|NERD_tree\|-MiniBuf' ? '' :
	\ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
	\ ('' != fname ? fname : '[No Name]') .
	\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD\|MiniBufExplorer' && exists('*fugitive#head')
      let mark = s:branch_mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ fname =~ '-MiniBufExplorer-' ? 'MiniBufExplorer' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
