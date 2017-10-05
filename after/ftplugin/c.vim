" Indenting
set tags=./tags

"command! UpdateTags execute ":silent ! ~/dotfiles/ctagger.sh % "| execute ":redraw!"
"autocmd BufWrite * :UpdateTags
set noscb

set textwidth=80  " lines longer than this columns will be broken, ignoring PEP8 error for +80
set shiftwidth=2  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=2     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=2 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
