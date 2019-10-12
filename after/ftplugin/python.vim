" Get suggestions straight away
let g:neocomplete#auto_completion_start_length = 0

" For pytags in bashrc to work you need to set:
set tags:.tags

" Python syntax checking
"let g:syntastic_python_checkers=[]
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args=' --ignore=E501'
set textwidth=0  " lines longer than this columns will be broken, ignoring PEP8 error for +80
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line"
set smarttab

