-- link to  ~/.config/nvim/init.lua

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'tomasr/molokai'

  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '~/',
          syntax = 'markdown',
          ext  = '.md',
        }
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
    end
  }

  -- LSP setup
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

end)

vim.g.colors_name = 'molokai'

-- Treesitter Config
  local configs = require'nvim-treesitter.configs'
  configs.setup {
    ensure_installed = "maintained", -- Only use parsers that are maintained
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    }
  }
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Completion Config
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- LSP Installer
  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {}
    -- Disable 'Undefined global `vim`' Errors
    if server.name == "sumneko_lua" then
        opts = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim', 'use' }
              },
              --workspace = {
                -- Make the server aware of Neovim runtime files
                --library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
              --}
            }
          }
        }
      end
    -- Setup completion capabilities once the server is enabled.
    require('lspconfig')[server.name].setup {
      capabilities = capabilities
    }
    server:setup(opts)
  end)

-- set a local function for cleaner config
  local keymap = vim.api.nvim_set_keymap
  local function nkeymap(key, map)
    local opts = { noremap = true }
    keymap('n', key, map, opts)
  end
  nkeymap('gd', ':lua vim.lsp.buf.definition()<cr>')
  nkeymap('gD', ':lua vim.lsp.buf.declaration()<cr>')
  nkeymap('gi', ':lua vim.lsp.buf.implementation()<cr>')
  nkeymap('gw', ':lua vim.lsp.buf.document_symbol()<cr>')
  nkeymap('gw', ':lua vim.lsp.buf.workspace_symbol()<cr>')
  nkeymap('gr', ':lua vim.lsp.buf.references()<cr>')
  nkeymap('gt', ':lua vim.lsp.buf.type_definition()<cr>')
  nkeymap('K', ':lua vim.lsp.buf.hover()<cr>')
  nkeymap('<c-k>', ':lua vim.lsp.buf.signature_help()<cr>')
  nkeymap('<leader>af', ':lua vim.lsp.buf.code_action()<cr>')
  nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<cr>')

-- Examples
  vim.cmd [[colorscheme molokai]] -- run vim command in lua

  -- Check OS
  if (vim.loop.os_uname().sysname == "Darwin") -- determin OS
  then
    print("Runing on Mac OS")
  else
    print("NOT Runing on Mac OS")
  end

  local function blah()
    print "hello world\n"
  end
