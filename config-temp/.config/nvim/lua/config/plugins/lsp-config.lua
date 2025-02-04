return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "vimls", "biome", "ts_ls" },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- setup auto-completion
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- setup lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim', 'hs' }
            },
            workspace = {
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                ['$XDG_CONFIG_HOME/hammerspoon/Spoons/EmmyLua.spoon/annotations'] = true,
              },
            },
          }
        }
      })

      -- setup typescript
      lspconfig.ts_ls.setup({})

      -- setup typescript
      lspconfig.biome.setup({})

      -- keybindings
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- format on save action
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- if client.supports_method('textDocument/completion') then
          --   -- enable auto-completion
          --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
          -- end

          if client.supports_method('textDocument/formatting') then
            -- format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end
  }
}
