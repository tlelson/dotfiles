set textwidth=120  " Arbitary but practical for splitscreen vim on a laptop
" Go Uses Tabs  - So don't set vars like `expandtab` or `smarttab`
"set smarttab
"set expandtab     " Do not expand to spaces for go
set tabstop=4       " Display size of a tab
set shiftwidth=4    " Display size of indentation operation

" Format option 1
" Using vim-go calles GoFmt on write
"function GoFormat()
	"call StripTrailingWhitespaces()
	"" Format option 1
	"":YcmCompleter Format
	"" Sorts imports alphabetically
	"" Format option 2
	"" dangerous. Will remove all code so if you
	"" miss something and accidentally save before undo
	"" you'll loose your uncommited edits.
	""seperating stdlib and external first)
	""let l = line(".")
	""let c = col(".")
	"":%!goimports " Fuckin dangerous
	""call cursor(l, c)
"endfunction
"autocmd BufWritePre * :call GoFormat()
