-- This configuration comes from: https://github.com/LunarVim/Neovim-from-scratch
-- If theres something you want, look there first.
--
-- TODO: Work out why `gf` to file doesn't work using after/ftplugin/lua.lua
require "user.options"
require "user.keymaps"
require "user.commands"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
-- require "user.telescope"
require "user.treesitter"
require "user.fugitive"
require "user.nerdcommenter"
require "user.autopairs"
