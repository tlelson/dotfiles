set textwidth=0
command! FixHTML execute ":%s/<[^>]*>/\r&\r/g" | execute ":%g/^$/d" | normal gg=G

" CONVERT TO JADE AND DISPLAY IN SPLIT
" need to $ npm install -g html2jade
function! HTMLToJade()
  let cur_file=expand('%:t')
  let cleaned_name = substitute(cur_file, '^\s*\(.\{-}\)\s*$', '\1', '')
  let s:jade_file = substitute(cleaned_name, '\(.*\)\.html$', '/tmp/\1.jade', '')
  echo s:jade_file
  let shellcmd = "html2jade -o /tmp % 2> ".s:jade_file
  silent execute '!'.shellcmd
  redraw!
  execute 'vsplit' s:jade_file
endfunction

"! /usr/local/bin/html2jade % | vsplit %
"nmap <silent> <leader>ty :call Hex2dec()<CR>
command! ToJade :call HTMLToJade()
set noscrollbind
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2

