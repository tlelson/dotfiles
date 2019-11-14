let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'text' :  '~/.vim/after/ftplugin/4000-words.txt'
    \ }

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set noscrollbind
set textwidth=1000  "Dont want \n in my copy pasted cmds
setlocal spell spelllang=en_au  "local so not added to other open code buffers
autocmd VimEnter * Limelight  " On by default
