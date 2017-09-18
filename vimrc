"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/minmac/.vim')
  call dein#begin('/Users/minmac/.vim')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/minmac/.vim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neocomplcache.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('scrooloose/nerdcommenter')
  "call dein#add('Raimondi/delimitMate')
  call dein#add('ervandew/supertab')
  call dein#add('vim-syntastic/syntastic')

  " You can specify revision/branch/tag.
  "call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " TypeScript Stuff
  call dein#add('Quramy/tsuquyomi')
  call dein#add('Quramy/vim-js-pretty-template')
  call dein#add('leafgarland/typescript-vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts------------------------- "

" AUTOCOMPLETE stuff ----------------------------------------------------------"
" Enable omni completion.
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" end AUTOCOMPLETE stuff ----------------------------------------------------------"

" NERDTREE -------------------------------------------------------------------
" Open Nerdtree automatically if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" N.B NEED BLANK LINE ABOVE !! no idea why by without it NERDTree fails to
" load and vim errors
"let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.o$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <F3> :NERDTreeToggle<CR>
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

" EFFICIENCY - (my shortcuts)
nmap ; :
"cmap 1 !
" format JSON
command Json execute ":%!python -m json.tool"
" Faster macro repeat
nnoremap Q @q
" Indent code blocks
vnoremap < <gv
vnoremap > >gv
" Match symbol mapping
imap <C-S-r> <C-k>r*
imap <C-S-x> <C-k>x*
imap <C-S-s> <C-k>s* " This doesn't work for some reason.

" GENERAL APPEARANCE & BEHAVIOURS
syntax on
syntax enable
set background=dark
set ruler
set hlsearch "hilight search
" Dont use the following line unless you want to loose
" function of the arrow keys
"nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" Test leader type leader then letter 'a'
nnoremap <Leader>a :echo "Hey there "<CR>

" Configure code folding
set foldmethod=indent
set foldnestmax=10
set foldlevel=1

" Override this for filetypes
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set scrollbind!

set cindent
set autoindent

" FILETYPES
filetype on
filetype plugin on
filetype indent on

set title "Sets title of tab to be the filename

" Clear Whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Recognise Filetypes (autocmd)
" others done automatically, check with :set ft
au BufRead,BufNewFile *.txt     set ft=text
au BufRead,BufNewFile *.coffee  set ft=coffee
au BufRead,BufNewFile *.jade    set ft=jade
au BufNewFile,BufRead *.lib     set ft=sh
au BufNewFile,BufRead *.ps1     set ft=ps1
au BufNewFile,BufRead *.pp      set ft=puppet
au BufRead,BufNewFile *.ts      set ft=typescript

" Possibly should just set a wrap length and then i can easily flip back to nowrap if i want
set colorcolumn=120
highlight ColorColumn ctermbg=8
set textwidth=120

" NERDCOMMENTER config ---------------------------------------------------
" This let you use Ctrl+/ to comment blocks
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
" Multiline comments
"nmap <C-_> <leader>cm
"vmap <C-_> <leader>cm

" TYPESCRIPT -------------------------------------------------------------"
" Tsuquyomi
autocmd FileType typescript setlocal completeopt+=menu,preview
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
" LEAFGARLAND/TYPESCRIPT
autocmd FileType typescript :set makeprg=tsc
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" SYNTASTIC -------------------------------"
" (will auto check on :w {!! not :wq} and display Help window at bottom)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"let g:syntastic_<filetype>_checkers = ['<checker-name>']

" NEOSNIPPETS - default is <C-k> but need this for symbols
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
