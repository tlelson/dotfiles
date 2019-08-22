"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim')
  call dein#begin('~/.vim')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neocomplcache.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('ervandew/supertab')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('kristijanhusak/vim-multiple-cursors')
  call dein#add('vim-airline/vim-airline')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround.git')
  call dein#add('Glench/Vim-Jinja2-Syntax')
  call dein#add('mileszs/ack.vim')
  call dein#add('fatih/vim-go')  "then  :GoInstalBinaries
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0  })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf'  })  " See fzf config in mybashrc
  call dein#add('eL0ck/vim-code-dark')

  " Experimental
  "call dein#add('reedes/vim-lexical')
  call dein#add('elixir-editors/vim-elixir')

  " You can specify revision/branch/tag.
  "call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " TypeScript Stuff
  call dein#add('leafgarland/typescript-vim')
  call dein#add('Quramy/tsuquyomi')
  call dein#add('Quramy/vim-js-pretty-template')
  "call dein#add('pangloss/vim-javascript')  " DONOT USE, BREAKS tsuquyomi !!
  "call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts------------------------- "
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

"GitGutter
set updatetime=100

"Ripgrep integration
if executable("rg")
    let g:ackprg = 'rg --vimgrep --no-heading'
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Auto-Pairs
" the line below wrapps a word witout the default Meta key
let g:AutoPairsShortcutFastWrap = '<leader>wr'

" Fugitive
" Consitent command for reviewing file changed before commit
command Greview :Git! diff --staged

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
" Try this, should reduce the options
set completeopt=longest,menuone

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
let g:NERDTreeIgnore=[
            \'__pycache__',
            \'^build$',
            \'^dist$',
            \'\.pyc',
            \'\.egg-info'
            \]

" N.B NEED BLANK LINE ABOVE !! no idea why by without it NERDTree fails to
" load and vim errors
"let NERDTreeChDirMode=2
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
map <F3> :NERDTreeToggle<CR>
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

" EFFICIENCY - (my shortcuts)
" Spell checking: Ctrl-f moves to the next error and chooses the first
" suggestion
imap <c-f> <c-g>u<Esc>]s1z=`]a<c-g>u
nmap <c-f> ]s1z=<c-o>

" The following line keep the current register after you put it (multiple pastes)
vnoremap p "_dP
set tags=.tags "this is where pytags alias in bashrc is saving them
if &diff == 'nodiff'
    set shellcmdflag=-c
endif
set shell=/usr/bin/env\ bash\ --rcfile\ ~/.bashrc  "Load alias etc, DONOT use interactive (-i)
nmap ; :
"cmap 1 !
" format JSON from Python Dict.  See below, the quote rules are too general
" TODO: Should use the python json.load/dump instead
function DictToJson()
    silent! %s/ True/ "True"/g            " Two ways of suppressing output.  Here silent flag
    %s/ False/ "False"/ge                 " ... here use the 'e'
    %s/u'/"/g
    %s/'/"/g
    execute ":%!python -m json.tool"
endfun
command DictToJson call DictToJson()
" Format unindented JSON
function JSON()
    execute ":%!python -m json.tool"
endfun
command JSON call JSON()

" MACROS
" Faster macro repeat
nnoremap Q @q
set nowrapscan  " If using search in a macro you dont want it repeating endlessly

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
colorscheme codedark
set ruler
set hlsearch "hilight search
" Dont use the following line unless you want to loose
" function of the arrow keys
"nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
"set scrolloff=3 "scrolls before hitting the bottom
" Think this is causing the random jump up Nope ... not solely at least

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
set noscrollbind

set cindent
set autoindent

" FILETYPES
filetype on
filetype plugin on
filetype indent on

set title "Sets title of tab to be the filename

" Clear Whitespace on save
"autocmd BufWritePre * :%s/\s\+$//e
" Above autocmd was make the cursor skip up randomly even when not saving! might be a conflict with a plugin?? Think it
" would be fine if it was set up after all plugins
" Trying below:
" UPDATE: Fails but leaving it in
function! <SID>StripTrailingWhitespaces()
    retab
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Recognise Filetypes (autocmd)
" others done automatically, check with :set ft
autocmd BufNewFile,BufRead Dockerfile* set syntax=Dockerfile
autocmd BufRead,BufNewFile *.txt     set ft=text
autocmd BufRead,BufNewFile *.coffee  set ft=coffee
autocmd BufRead,BufNewFile *.jade    set ft=jade
autocmd BufNewFile,BufRead *.lib     set ft=sh
autocmd BufNewFile,BufRead *.ps1     set ft=ps1
autocmd BufNewFile,BufRead *.pp      set ft=puppet
autocmd BufRead,BufNewFile *.ts      set ft=typescript
"autocmd BufNewFile,BufRead *.json,*.html,*.htm,*.shtml,*.stm set ft=jinja

" Possibly should just set a wrap length and then i can easily flip back to nowrap if i want
"set colorcolumn=120
highlight ColorColumn ctermbg=8
"set textwidth=120

" NERDCOMMENTER config ---------------------------------------------------
" This let you use Ctrl+/ to comment blocks
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>
" Multiline comments
"nmap <C-_> <leader>cm
"vmap <C-_> <leader>cm

" TYPESCRIPT and JAVASCRIPT------------------------------------------------"
" TSUQUYOMI
" So far works as: synstatic checker, <C-]> <C-t> jump to defintion, <C-^> for other occurances, BUT NOT tooltip!
" Debuggin TSUQUYOMI:
"   :TsuquyomiStatusServer
"   :TsuquyomiStartServer  - found this doesn't work well. Even reopening it didn't work.  Had to remove .vim/ and use
"   ./setup_vim.sh again !!
autocmd FileType typescript setlocal completeopt+=menu
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
" LEAFGARLAND/TYPESCRIPT
"autocmd FileType typescript :set makeprg=tsc
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow


" SYNTASTIC -------------------------------"
" !! You need the checker to work on the CLI before expecting it to work in file (on write)
"   For example: check eslint works by $ eslint <filename>
"   (with the exception of tsuquyomi which is hard to debug)
" (will auto check on :w {!! not :wa or :wq} and display Help window at bottom)
" Debug in vim by seting: :let g:syntastic_debug = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"let g:syntastic_<filetype>_checkers = ['<checker-name>']

" TAB COMPLETE STUFF
" Make it start at the top
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" NEOSNIPPETS - default is <C-k> but need this for symbols
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

" NEOCOMPLETE
set completeopt-=preview  "Disable preview window

" MULTI-CURSOR
" Default mapping - Also use visual selection <C-n> and regex selection
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_insert_mode=0
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteDisable')==2
    exe 'NeoCompleteDisable'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteEnable')==2
    exe 'NeoCompleteEnable'
  endif
endfunction

" MOVE SPLITS - \mw to mark first window, \pw to mark and swap with the second
"function! MarkWindowSwap()
    "let g:markedWinNum = winnr()
"endfunction
"function! DoWindowSwap()
    ""Mark destination
    "let curNum = winnr()
    "let curBuf = bufnr( "%" )
    "exe g:markedWinNum . "wincmd w"
    ""Switch to source and shuffle dest->source
    "let markedBuf = bufnr( "%" )
    ""Hide and open so that we aren't prompted and keep history
    "exe 'hide buf' curBuf
    ""Switch to dest and shuffle source->dest
    "exe curNum . "wincmd w"
    ""Hide and open so that we aren't prompted and keep history
    "exe 'hide buf' markedBuf
"endfunction
"nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
"nmap <silent> <leader>sw :call DoWindowSwap()<CR>"

" Making it faster to set paste mode
" Option 1 - map pastetoggle to a key
"set pastetoggle=<F2>

" Option 2 - Auto paste toggle before and after paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
