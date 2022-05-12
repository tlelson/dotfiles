setlocal textwidth=100  " Arbitary but practical for splitscreen vim on a laptop
augroup go_autocmds
	autocmd!
	autocmd BufWritePre <buffer> Format
	" Add one for !goimports too
augroup end
