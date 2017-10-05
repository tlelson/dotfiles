
" Disable Easytags for Python
let g:easytags_on_cursorhold = 0
let g:easytags_auto_update = 0
let g:easytags_auto_highlight = 0

" Tags - easytags really isn't doing anything right for python and this the autocmd doesn't seem to
" load or is at least being concatenated to the easycommand one which is overwriting it.
"let g:easytags_opts = ['-R', '--language-force=python', '--python-kinds=-i']
"let g:easytags_cmd = '/usr/local/bin/ctags -R --language-force=python --python-kinds=-i'
"let g:easytags_opts = ['--options=$HOME/dotfiles/ctags/python.cnf'] " This simply does NOT apply
command! UpdateTags execute ":silent ! ctags -R --language-force=python --python-kinds=-i --exclude=*.hdf -f .tags * "| execute ":redraw!"
" This can be pretty hard work for Vim if high in a file tree. Do tags manually
"autocmd BufWrite * :UpdateTags
"autocmd BufWrite * :set number

" Get suggestions straight away
let g:neocomplete#auto_completion_start_length = 0

set noscb

" PEP8
let g:syntastic_python_checkers=['flake8', 'pyflakes', 'python'] "disable for errors only
"let g:syntastic_python_checkers=['python'] "For working with code you don't want to fix!!
let g:syntastic_python_flake8_args='--ignore=E126,E128,E501'
set textwidth=120  " lines longer than this columns will be broken, ignoring PEP8 error for +80
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line"
set smarttab

