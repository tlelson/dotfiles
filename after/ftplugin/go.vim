
set textwidth=0  " lines longer than this columns will be broken, ignoring PEP8 error for +80
" Go Uses Tabs  - So don't set vars like `expandtab` or `smarttab`
"set smarttab
"set expandtab     " Do not expand to spaces for go
set tabstop=4       " Display size of a tab
set shiftwidth=4    " Display size of indentation operation

function GoFormat()
	call StripTrailingWhitespaces()
	:YcmCompleter Format
endfunction
autocmd BufWritePre * :call GoFormat()
