"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/minmac/.vim/dein_installs/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/minmac/.vim/dein_installs')
  call dein#begin('/Users/minmac/.vim/dein_installs')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/minmac/.vim/dein_installs/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
"
" NERDTREE
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

" GENERAL APPEARANCE & BEHAVIOURS
syntax on
syntax enable
set background=dark
set ruler
set hlsearch

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
au BufRead,BufNewFile *.txt     setfiletype text
au BufRead,BufNewFile *.coffee  setfiletype coffee
au BufRead,BufNewFile *.jade    setfiletype jade
au BufNewFile,BufRead *.lib     set ft=sh
au BufNewFile,BufRead *.ps1     set ft=ps1
au BufNewFile,BufRead *.pp      set ft=puppet

" Possibly should just set a wrap length and then i can easily flip back to nowrap if i want
set textwidth=100
