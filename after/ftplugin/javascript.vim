"set textwidth=0

"set tabstop=2
"set expandtab
set shiftwidth=2
"set softtabstop=2

set colorcolumn=100
highlight ColorColumn ctermbg=8
set textwidth=100

let g:syntastic_javascript_checkers = ['eslint']
set noscrollbind

" OLD SHIT I PROBLY SHOULD DELETE BELOW -------------"
"
" CONVERT TO Coffee AND DISPLAY IN SPLIT
" need to $ npm install -g js2coffee
function! JavascriptToCoffeeWorker()
  "let cur_file=expand('%:t')
  "let cleaned_name = substitute(cur_file, '^\s*\(.\{-}\)\s*$', '\1', '')
  "let s:coffee_file = substitute(cleaned_name, '\(.*\)\.js$', '/tmp/\1.coffee', '')
  "echo s:coffee_file
  normal G
  normal o
  read ! echo "/*---------------------Coffee----------------------*/"
  read ! js2coffee % | sed  '/^\s*return\s*$/d'
  "execute 'vsplit' s:coffee_file
  "echo s:coffee_file
endfunction

command! ToCoffee :call JavascriptToCoffeeWorker()

