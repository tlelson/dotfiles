local configs = require("nvim-treesitter.configs")
configs.setup {
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  -- Treesitters indent seems to double up on indents created by vim using
  -- smartindent/autoindent.  When this feature is out of dev consider it again.
  indent = { enable = false, disable = { "yaml" } },
}
