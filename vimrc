" PLUGINS
call plug#begin('~/.vim/plugged')
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-surround'
	Plug 'eL0ck/vim-code-dark'
	Plug 'junegunn/seoul256.vim'
	Plug 'junegunn/fzf', { 'do': './install --all'}
	Plug 'junegunn/fzf.vim', { 'depends': 'fzf'  }
	Plug 'Shougo/neosnippet.vim'  " Only seem to use these for ipdb
	Plug 'Shougo/neosnippet-snippets'  " As above 
	Plug 'vim-airline/vim-airline'
	Plug 'scrooloose/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin', " MUST DISABLE for large typescript repos
	Plug 'airblade/vim-gitgutter'
	Plug 'scrooloose/nerdcommenter'
	" YCM SHOULD COMMENTED OUT FOR NEW INSTALLS !!
	" Install go binary, `apt-packs` and nodejs BEFORE installing YCM
	Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer --ts-completer'} 
	Plug 'vim-syntastic/syntastic', { 'for': ['python', 'yaml'] }  " YCM for others
	Plug 'jiangmiao/auto-pairs'  
	Plug 'leafgarland/typescript-vim'
	Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python'] }
	Plug 'ludovicchabant/vim-gutentags'
call plug#end()

"------------------- Efficiency --------------------------------------------------------
	" Auto paste toggle before and after paste - Never Remove!!
		let &t_SI .= "\<Esc>[?2004h"
		let &t_EI .= "\<Esc>[?2004l"
		inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
		function! XTermPasteBegin()
		  set pastetoggle=<Esc>[201~
		  set paste
		  return ""
		endfunction
	" Test leader type leader then letter 'a'
		set nu
		nnoremap <Leader>a :echo "Hey there "<CR>
	" Spell checking: Ctrl-f moves to the next error and chooses the first
	" suggestion
		imap <c-f> <c-g>u<Esc>]s1z=`]a<c-g>u
		nmap <c-f> ]s1z=<c-o>
	" The following line keep the current register after you put it (multiple pastes)
		vnoremap p "_dP
		"set tags=.tags "this is where pytags alias in bashrc is saving them
	" Below allows tag to open in a new tab - from naveen
		nnoremap <space><C-]> :tab tag <C-r><C-w><CR>  
		if &diff == 'nodiff'
			set shellcmdflag=-c
		endif
		set shell=/usr/bin/env\ bash\ --rcfile\ ~/.bashrc  "Load alias etc, DONOT use interactive (-i)
		nmap ; :
	" JSON fixer
		function JSON()
			execute ":%!python -m json.tool --sort-keys"
		endfun
		command JSON call JSON()
	" MACROS
		" Faster macro repeat
			nnoremap Q @q
			set nowrapscan  " If using search in a macro you dont want it repeating endlessly

		" Indent code blocks
			vnoremap < <gv
			vnoremap > >gv

	" Clear Whitespace on save
		function StripTrailingWhitespaces()
			%retab!
			let l = line(".")
			let c = col(".")
			%s/\s\+$//e
			call cursor(l, c)
		endfun
		"Disabling for work with Ian
		"autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"------------------- Style/Appearance ----------------------------------------
	" COLOR
		color codedark " torte, elflord, 
		" seoul256 (dark):
		"   Range:   233 (darkest) ~ 239 (lightest)
		"   Default: 237
		"let g:seoul256_background = 234

	" Inherit Background color from terminal
		" Should these be in the color scheme ??
		"so $VIMRUNTIME/syntax/hitest.vim	
		"highlight Normal ctermbg=none guibg=NONE
		"highlight LineNr ctermbg=none guibg=NONE 
		"highlight NonText ctermbg=none guibg=NONE 
		"highlight EndOfBuffer ctermbg=none guibg=NONE 
		"highlight Directory ctermbg=none guibg=NONE 

	" Configure code folding
		set foldmethod=indent
		set foldnestmax=10
		set foldlevel=1

	" Default here: Override this for filetypes 
		" Generic policy is to just leave whatever space exists be (tab or space)
		" and set file specific in after files.
		set tabstop=4  		" Size of a tab
		set shiftwidth=4  	" Size of indentation operation
		" set expand tab 	" NO!

	" Misc
		set noscrollbind
		set cindent
		set autoindent

	" Recognise Filetypes (autocmd)
		" others done automatically, check with :set ft
		autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
		autocmd BufRead,BufNewFile *.txt     set ft=text
		autocmd BufRead,BufNewFile *.coffee  set ft=coffee
		autocmd BufRead,BufNewFile *.jade    set ft=jade
		autocmd BufNewFile,BufRead *.lib     set ft=sh
		autocmd BufNewFile,BufRead *.ps1     set ft=ps1
		autocmd BufNewFile,BufRead *.pp      set ft=puppet
		autocmd BufRead,BufNewFile *.ts      set ft=typescript
		"autocmd BufNewFile,BufRead *.json,*.html,*.htm,*.shtml,*.stm set ft=jinja

	" Visualise whitespace (:set list)
		set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<  

" ------------------- Plugin Settings -------------------
	" NEOSNIPPETS - default is <C-k> but need this for symbols
		imap <C-j>     <Plug>(neosnippet_expand_or_jump)
		smap <C-j>     <Plug>(neosnippet_expand_or_jump)
		xmap <C-j>     <Plug>(neosnippet_expand_target)

	"GITGUTTER
		set updatetime=1000
		"let g:gitgutter_log=1 "For debugging issues
		"let g:gitgutter_async=0 "Was failing when trying asyncronoushly

	" NERDTREE
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
		let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ 'Ignored'   : '☒',
			\ "Unknown"   : "?"
			\ }


		" N.B NEED BLANK LINE ABOVE !! no idea why by without it NERDTree fails to
		" load and vim errors
		"let NERDTreeChDirMode=2
		let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
		let NERDTreeShowBookmarks=1
		map <F3> :NERDTreeToggle<CR>
		"let NERDTreeMinimalUI = 1
		"let NERDTreeDirArrows = 1

	" YCM
		" Alternative to tags. Ycm uses the jump list
		nnoremap <leader>d :YcmCompleter GoTo<CR>  
		map K :YcmCompleter GetDoc<CR>
		let g:ycm_auto_trigger = 1      " Require <C-Space> to show completion options. `1` shows automatically
		let g:ycm_max_num_identifier_candidates = 0  " Show all completion candidates
		let g:ycm_autoclose_preview_window_after_completion = 1
		let g:ycm_autoclose_preview_window_after_insertion = 1
		set  completeopt=menuone  " Remove `preview` window by default
		let g:ycm_filetype_blacklist = {
			  \ 'nerdtree': 1,  
			  \ 'tagbar': 1,
			  \ 'netrw': 1,
			  \ 'unite': 1,
			  \ 'vimwiki': 1,
			  \ 'pandoc': 1,
			  \ 'infolog': 1,
			  \ 'leaderf': 1,
			  \ 'mail': 1
			  \}

	" SYNTASTIC
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
		let g:syntastic_check_on_open = 0
		let g:syntastic_check_on_wq = 0  " Default off

	" NERDCOMMENTER config
		" This let you use Ctrl+/ to comment blocks
		nmap <C-_> <leader>c<Space>
		vmap <C-_> <leader>c<Space>
	 
	" FZF config
		"Ripgrep integration
		if executable("rg")
			let g:ackprg = 'rg --vimgrep --no-heading'
			set grepprg=rg\ --vimgrep\ --no-heading
			set grepformat=%f:%l:%c:%m,%f:%l:%m
		endif
		" :Rg (comes from fzf-vim)
		"let g:fzf_layout = { 'down': '~20%' }
		"Redefine Rg command to allow rg arguments to pass through
		" such as `-tyaml` for yaml files or `-F` for literal strings
		command! -bang -nargs=* Rg
		  \ call fzf#vim#grep(
		  \   'rg -L --column --line-number --no-heading --color=always --smart-case '.(<q-args>), 1,
		  \   <bang>0 ? fzf#vim#with_preview('up:60%')
		  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
		  \   <bang>0)
		"let g:fzf_tags_command = 'ctags --exclude=*json -R'

	" GUTENTAGS 
		" config project root markers.
		"let g:gutentags_project_root = ['.root']
		" generate datebases in my cache directory, prevent gtags files polluting my project
		let g:gutentags_cache_dir = expand('~/.cache/tags')
		" change focus to quickfix window after search (optional).
		let g:gutentags_plus_switch = 1
		set statusline+=%{gutentags#statusline()}
		"let g:gutentags_trace = 1
		let g:gutentags_ctags_auto_set_tags = 1
		
