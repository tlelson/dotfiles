" ------------------- Vundle Stuffs -----------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" My Plugins -------------------------------------------------
" AutoComplete Stuff
Plugin 'https://github.com/Shougo/neocomplete.vim.git'

Plugin 'https://github.com/davidhalter/jedi-vim.git' "This IS usefull even with neocomplcomplete
Plugin 'https://github.com/Shougo/neosnippet.git'
Plugin 'Shougo/neosnippet-snippets'
"Plugin 'Shougo/neocomplcache.git'  " Think this is replaced by neocomplete
Plugin 'git://github.com/Raimondi/delimitMate.git'
"Plugin 'git://github.com/majutsushi/tagbar'
"Bundle 'pangloss/vim-javascript'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/szw/vim-maximizer.git'

"Both are 'easy tags'
"Plugin 'https://github.com/xolox/vim-misc.git'
"Plugin 'https://github.com/xolox/vim-easytags.git'

" CoffeeScript Syntax hylighting
Bundle 'kchmck/vim-coffee-script'

" Syntax checking
" do this to get list of available checkers:
"   :SyntasticInfo
Bundle 'https://github.com/scrooloose/syntastic.git'

" Try CoffeeTags, must do
" $ gem install CoffeeTags
" $ coffeetags -h
"Bundle 'lukaszkorecki/CoffeeTags'

"LATEX
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" End my Plugins -------------------------------------------------

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" --------------------- End vundles stuff -----------------------------
" --------------------- NeoComplete Stuff -----------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

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

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
set ofu=syntaxcomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" --------------------- End NeoComplete Stuff -------------------------

" --------------------- My stuff --------------------------------------
" MAXIMISER stuff
nnoremap <silent><F3> :MaximizerToggle<CR>
vnoremap <silent><F3> :MaximizerToggle<CR>gv
inoremap <silent><F3> <C-o>:MaximizerToggle<CR>

" NEOSNIPPETS - default is <C-k> but need this for symbols
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif"

" NERDTREE
" Close nerdtree if its the only window left
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open Nerdtree automatically if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.o$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <F3> :NERDTreeToggle<CR>

" TAGS
" Store tags locally so they dont get confused or too big
:set tags=.tags
let g:easytags_dynamic_files = 2 "1 wont create a new tags file if not found and will revert to .viminfo
"let g:easytags_events = ['BufWritePost'] "Updates on save : Disabled because calls old 'UpdateTags'
"for python
"let g:easytags_autorecurse = 1 "Dont use, too dangerous at root dir.  use -R
"at command line instead. See python.vim
let g:easytags_resolve_links = 1 "Resolve symbolic links
"unlet b:easytags_auto_highlight  "Try without hylighting
" Debug easytags: use 1 or 2
:set vbs=0

" SYNTASTIC
" Debug
"let g:syntastic_debug = 1

" EFFICIENCY
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


" MOVE SPLITS - \mw to mark first window, \pw to mark and swap with the second
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction
function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" GENERAL APPEARANCE & BEHAVIOURS
syntax on
syntax enable
set background=dark
"set paste
set ruler
set hlsearch
"set mouse=nicr "Allows mouse scrolling
set foldmethod=indent
set foldnestmax=10
set foldlevel=1
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
au BufRead,BufNewFile *.txt     setfiletype text
au BufRead,BufNewFile *.coffee  setfiletype coffee
au BufRead,BufNewFile *.jade    setfiletype jade
au BufNewFile,BufRead *.lib     set ft=sh
au BufNewFile,BufRead *.ps1     set ft=ps1
au BufNewFile,BufRead *.pp      set ft=puppet

" Possibly should just set a wrap length and then i can easily flip back to nowrap if i want
set textwidth=100
