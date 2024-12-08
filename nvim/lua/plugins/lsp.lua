return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Cusomise the keymaps
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      --keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "<C-k>", mode = { "i" }, false }
      -- add a keymap
      --keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
    ---@class PluginLspOpts
    opts = {
      -- :help lspconfig-all  →
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      ---@type lspconfig.options
      servers = {
        -- servers bellow will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        gopls = {
          -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#buildflags-string
          -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#configuration
          settings = {
            gopls = {
              buildFlags = { "-tags=integration" },
              analyses = {
                fieldalignment = false, -- annoying struct memory warnings
              },
            },
          },
        },
        golangci_lint_ls = {},
      },
    },
  },
}
