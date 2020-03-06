set tags=
"command! UpdateTags execute ":silent ! ctags -R --language-force=python --python-kinds=-i "| execute ":redraw!"

let g:easytags_auto_update = 0
let g:easytags_on_cursorhold = 0

let g:syntastic_coffee_coffeelint_args = "--csv --file ~/dotfiles/coffeelint_config.json"

" For Quickfix listings
"npm install -g coffeelint
set noscrollbind
"set tabstop=8
"set expandtab
set shiftwidth=4
"set softtabstop=4
