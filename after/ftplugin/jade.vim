set textwidth=0

"set tabstop=8
"set expandtab
set shiftwidth=2
"set softtabstop=2

" CONVERT TO HTML AND DISPLAY IN SPLIT
" need to $ npm install -g jade
function! JadeToHTMLWorker()
  "let str=a:var1
  "let str2=a:var2
  "r ! ifconfig
  let cur_file=expand('%:t')
  let cleaned_name = substitute(cur_file, '^\s*\(.\{-}\)\s*$', '\1', '')
  let s:html_file = substitute(cleaned_name, '\(.*\)\.jade$', '/tmp/\1.html', '')
  echo s:html_file
  let shellcmd = "jade -o /tmp % 2> ".s:html_file
  silent execute '!'.shellcmd
  redraw!
  execute 'vsplit' s:html_file
endfunction

function! JadeToHTML()
    call JadeToHTMLWorker()
    "source ~/.vim/after/ftplugin/html.vim
    execute ":%s/<[^>]*>/\r&\r/ge" | execute ":silent! %g/^$/d"
    normal gg=G
    execute "w"
endfunction

"nmap <silent> <leader>ty :call Hex2dec()<CR>
command! ToHTML :call JadeToHTML()


" ------------------This allows gg=G to work -------------------

" Vim indent file
" Language: Jade
" Maintainer: Joshua Borton
" Credits: Tim Pope (vim-jade)
" Last Change: 2010 Sep 22

if exists("b:did_indent")
  finish
endif

unlet! b:did_indent
let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=GetJadeIndent()
setlocal indentkeys=o,O,*<Return>,},],0),!^F

" Only define the function once.
if exists("*GetJadeIndent")
  finish
endif

let s:attributes = '\%((.\{-\})\)'
let s:tag = '\([%.#][[:alnum:]_-]\+\|'.s:attributes.'\)*[<>]*'

if !exists('g:jade_self_closing_tags')
  let g:jade_self_closing_tags = 'meta|link|img|hr|br|input'
endif

setlocal formatoptions+=r
setlocal comments+=n:\|

function! GetJadeIndent()
  let lnum = prevnonblank(v:lnum-1)
  if lnum == 0
    return 0
  endif
  let line = substitute(getline(lnum),'\s\+$','','')
  let cline = substitute(substitute(getline(v:lnum),'\s\+$','',''),'^\s\+','','')
  let lastcol = strlen(line)
  let line = substitute(line,'^\s\+','','')
  let indent = indent(lnum)
  let cindent = indent(v:lnum)
  let increase = indent + &sw
  if indent == indent(lnum)
    let indent = cindent <= indent ? -1 : increase
  endif

  let group = synIDattr(synID(lnum,lastcol,1),'name')

  if line =~ '^!!!'
    return indent
  elseif line =~ '^/\%(\[[^]]*\]\)\=$'
    return increase
  elseif line =~ '^\%(if\|else\|unless\|for\|each\|block\|mixin\|append\|case\|when\)'
    return increase
  elseif line =~ '^'.s:tag.'[&!]\=[=~-].*,\s*$'
    return increase
  elseif line == '-#'
    return increase
  elseif line =~? '^\v%('.g:jade_self_closing_tags.')>'
    return indent
  elseif group =~? '\v^%(jadeAttributesDelimiter|jadeClass|jadeId|htmlTagName|htmlSpecialTagName|jadeFilter|jadeTagBlockChar)$'
    return increase
  else
    return indent
  endif
endfunction
set noscrollbind
