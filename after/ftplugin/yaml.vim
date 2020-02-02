"pip install yamllint
let g:syntastic_yaml_checkers=['yamllint']
let g:syntastic_yaml_yamllint_args=' --config-data "{extends: relaxed, rules: {line-length: {max: 120}}}" '

set textwidth=0
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set noscrollbind
set textwidth=80
autocmd VimEnter * Limelight  " On by default
