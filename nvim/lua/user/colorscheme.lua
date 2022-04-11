vim.cmd [[
try
  " colorscheme darkplus
  colorscheme codedark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
