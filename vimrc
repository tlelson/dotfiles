" PLUGINS
call plug#begin('~/.vim/plugged')
	Plug 'tlelson/vim-code-dark' " Forked for slight tweaks for transparent backgrounds

	" Gods of Vim
	Plug 'tpope/vim-unimpaired'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-endwise'
	Plug 'tpope/vim-sleuth'  " Removes need for any tabstop/softtabstop/expandtab settings
	Plug 'junegunn/fzf', { 'do': './install --all'}
	Plug 'junegunn/fzf.vim', { 'depends': 'fzf'  }
	" Navigation and Version Control
	Plug 'vim-airline/vim-airline'
	Plug 'airblade/vim-gitgutter'

	" Coding
	Plug 'scrooloose/nerdcommenter'
	Plug 'ludovicchabant/vim-gutentags'
	" Install go binary, `apt-packs` and nodejs BEFORE installing YCM
	Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer --ts-completer'}
	Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python'] }
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': ['go'] }
	Plug 'dense-analysis/ale'

	" Experimental
	Plug 'tlelson/vim-notebook', { 'branch': 'dev' }
	Plug 'mfukar/robotframework-vim'
call plug#end()

"------------------- NETRW -------------------------------------------------------------
	let g:netrw_banner = 0
	let g:netrw_liststyle = 3
	let g:netrw_preview = 1 " preview vertically
	let g:netrw_winsize = 15
	let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
	nnoremap <leader>rw :Vex<CR>

"------------------- Efficiency --------------------------------------------------------
	" Auto paste toggle before and after paste - Never Remove!!
		let &t_SI .= "\<Esc>[?2004h"
		let &t_EI .= "\<Esc>[?2004l"
		inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
		function! XTermPasteBegin()
		  set pastetoggle=<Esc>[201~
		  set paste " let &paste = 1
		  return ""
		endfunction

	" Test leader type leader then letter 'a'
		set nu
		nnoremap <Leader>a :echo "Hey there "<CR>

	" Spell checking: Ctrl-f moves to the next error and chooses the first suggestion
		imap <c-f> <c-g>u<Esc>]s1z=`]a<c-g>u
		nmap <c-f> ]s1z=<c-o>

	" The following line keep the current register after you put it (multiple pastes)
		vnoremap p "_dP

	" Misc
		if &diff == 'nodiff'
			set shellcmdflag=-c
		endif
		set shell=/usr/bin/env\ bash\ --rcfile\ ~/.bashrc  "Load alias etc, DONOT use interactive (-i)
		nnoremap ; :

	" JSON fixer
		function JSON()
			execute ":%!python -m json.tool --sort-keys"
		endfun
		command JSON call JSON()

		" Unfixer - Shrink all formated json to one line
		" and remove unnessesary spaces UNTESTED
		function JSONunpretty()
			%j 						" Remove linebreaks
			:%s/\v([{\[:,"]) /\1/g  " Space after
			:%s/\v ([}\]:,"])/\1/g  " Space before
		endfun

	" XML formatter
		function XML()
			%!python -c "import sys, xml.dom.minidom as x; print(x.parse(sys.stdin).toprettyxml())"
			g/^\s*$/d
			:execute "normal gg=G"
		endfunction
		command XML call XML()

	" MACROS
		" Faster macro repeat
		nnoremap Q @q
		set nowrapscan  " If using search in a macro you dont want it repeating endlessly

	" Indent code blocks
		vnoremap < <gv
		vnoremap > >gv

	" Clear Whitespace on save
		function StripTrailingWhitespaces()
			let l = line(".")
			let c = col(".")
			keepp %s/\s\+$//e
			call cursor(l, c)
		endfun
		augroup strip_space
			autocmd!
			autocmd BufWritePre * undojoin | :call StripTrailingWhitespaces()
		augroup end

	" Write under root
		command SudoWrite :execute ':silent w !sudo tee % > /dev/null' | :edit!

	" Terminal Mode
		" Use standard escape to exit insert mode
		"tnoremap <Esc> <C-\><C-n>

	" Tabs/Splits/Windows
		set splitright " Default all splits to go right
		" These are default key bindings for the functionality but slighly
		" modified for effect
		nnoremap <C-w>+ :resize +10<CR>
		nnoremap <C-w>- :resize -10<CR>
		nnoremap <C-w>> :vert resize +10<CR>
		nnoremap <C-w>< :vert resize -10<CR>
		nnoremap <C-w>] :vsplit +tag\ <C-r><C-w><CR>

"------------------- Style/Appearance ----------------------------------------
	" COLOR
		color codedark " torte, elflord,
		" seoul256 (dark):
		"   Range:   233 (darkest) ~ 239 (lightest)
		"   Default: 237
		"let g:seoul256_background = 234

	" Configure code folding
		set foldmethod=indent
		set foldnestmax=10
		set foldlevel=1

	" Misc
		set tabstop=4
		set noscrollbind
		set cindent
		set autoindent

	" Set Filetypes for those not guessed
		augroup ft_set
			autocmd!
			autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
			autocmd BufNewFile,BufRead *.txt     set ft=text
			autocmd BufNewFile,BufRead *.coffee  set ft=coffee
			autocmd BufNewFile,BufRead *.jade    set ft=jade
			autocmd BufNewFile,BufRead *.lib     set ft=sh
			autocmd BufNewFile,BufRead *.ps1     set ft=ps1
			autocmd BufNewFile,BufRead *.pp      set ft=puppet
			autocmd BufNewFile,BufRead *.ts      set ft=typescript
			autocmd BufNewFile,BufRead *.mdx     set ft=markdown
			autocmd BufNewFile,BufRead *bashrc   set ft=bash
		augroup end

	" Visualise whitespace (:set list)
		set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" ------------------- Plugin Settings -------------------
	" SURROUND
		" Auto close following only (not quotes)
		imap { <C-s>}
		imap {<CR> <C-s><C-s>}
		imap ( <C-s>)
		imap (<CR> <C-s><C-s>)
		"Allow empty
		imap () ()
		imap {} {}

	" GITGUTTER
		set updatetime=1000
		"let g:gitgutter_log=1 "For debugging issues
		"let g:gitgutter_async=0 "Was failing when trying asyncronoushly

	" YCM
		"let g:ycm_always_populate_location_list = 1
		"let g:ycm_open_loclist_on_ycm_diags = 1
		"let g:ycm_warning_symbol = '??'
		let g:ycm_auto_trigger = 1  " Complete without Ctrl-<space>
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

		" Alternative to tags. Ycm uses the jump list
		nnoremap <leader>d :YcmCompleter GoTo<CR>
		function GoToType()
			:split
			:YcmCompleter GoToType
			:execute "normal zt"
		endfunction
		noremap	T :call GoToType()<CR>

		" Disable automatic doc popup. Manually control
		let g:ycm_auto_hover=''
		" This needs be allow recursive mappings ?!
		nmap <C-p> <plug>(YCMHover)

	" NERDCOMMENTER config
		" This let you use Ctrl+/ to comment blocks
		nmap <C-_> <leader>c<Space>
		vmap <C-_> <leader>c<Space>

	" FZF config
		"Ripgrep integration
		" Rg search word under cursor
		nnoremap <leader>rg :execute 'Rg ' . expand('<cword>')<CR>
		" Override default vim history with FZF's
		cnoremap <C-f> :execute 'History:'<CR>
		nnoremap q/ :execute 'History:'<CR>
		" Have Ripgrep start from the current buffers root, not the cwd of the
		" file first opened in vim. Think scenario when you jumped to a
		" library
		command! -bang -nargs=* Rg
  			\ call fzf#vim#grep(
			\ 	"rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
			\   {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

	" GUTENTAGS
		" config project root markers.
		let g:gutentags_project_root = ['.root']
		" generate datebases in my cache directory, prevent gtags files polluting my project
		let g:gutentags_cache_dir = expand('~/.cache/tags')
		" change focus to quickfix window after search (optional).
		let g:gutentags_plus_switch = 1
		set statusline+=%{gutentags#statusline()}
		"let g:gutentags_trace = 1
		let g:gutentags_ctags_auto_set_tags = 1

	" VIM-GO
		let g:go_diagnostics_enabled = 0 " Doesn't seem to update properly. Using ALE instead.
		let g:go_fmt_fail_silently = 1 " don't open location list by default
		let g:go_metalinter_enabled = ['golint', 'stylecheck'] " wsl
		let g:go_fmt_experimental = 1  " To stop folds being closed on write
		let g:go_def_mapping_enabled = 0 " Disable remap to Ctrl-] Ctrl-T
		let g:go_list_type = "quickfix" " There's a conflict with ALE when GoTest tries to populate the locationlist
		let g:go_term_enabled = 1
		let g:go_term_mode = "silent belowright 15 split"
		"let g:go_debug_log_output = 'debugger'
		let g:go_debug_log_output = 'lldbout'
		let g:go_debug_windows = {
			  \ 'vars':       'rightbelow 80vnew',
			  \ 'stack':      'rightbelow 20new',
			  \ 'out':        'botright 5new',
		\ }

	" ALE
		let g:ale_completion_enabled = 0
		let g:ale_python_flake8_options = '--ignore=E501,W503'
		let g:ale_python_pylint_options = '--disable=C0114,C0103,C0301,W1203,W1202'
		let g:ale_python_black_options = '--line-length=120'
		let g:ale_yaml_yamllint_options = '-c=$HOME/.yamllint.yaml'
		let g:ale_sign_error = '✗'
		let g:ale_linters = {
		\  'cloudformation': ['cfn-lint'],
		\  'python': ['mypy', 'flake8', 'pylint', 'pyright'],
		\}
		let g:ale_fix_on_save = 1 " ALEFix if you need it
		let g:ale_fixers = {
		\  '*': ['remove_trailing_lines', 'trim_whitespace'],
		\  'javascript': ['remove_trailing_lines', 'trim_whitespace', 'eslint', 'prettier', 'importjs'],
		\  'python': ['remove_trailing_lines', 'trim_whitespace', 'black', 'isort'],
		\  'yaml': ['remove_trailing_lines', 'trim_whitespace', 'yamlfix'],
		\}

	" Fugitive
		nnoremap <leader>gs :Git<CR>
		nnoremap <leader>gl :Gclog<CR>
		nnoremap <leader>ge :Gedit<CR>
		nnoremap <leader>gb :Gblame<CR>
