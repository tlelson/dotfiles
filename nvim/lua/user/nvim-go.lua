-- setup nvim-go
require('go').setup({
  linter = 'golangci_lint',
  lint_prompt_style = 'vf',
  formatter = 'gofmt',
})
