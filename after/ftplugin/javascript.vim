"set textwidth=0

set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

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

" N.B Currently only installed in the conda env 'serverless-dev'
let g:syntastic_javascript_checkers = ['eslint']

set noscb
