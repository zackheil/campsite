return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      'b0o/nvim-tree-preview.lua',
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- '3rd/image.nvim', -- Optional, for previewing images
      },
    },
  },
  keys = {
    { "<leader>re", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in filetree" },
    { "<C-n>",      "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file tree visibility" },
  },
  config = function()
    require("nvim-tree").setup({
      filters = {
        custom = { "^.git$" },
        dotfiles = false,
        git_clean = false,
      },
      renderer = {
        icons = {
          glyphs = {
            modified = "●",
            git = {
              unstaged = "󱇨",
              staged = "󱀻",
              unmerged = "󰩌",
              renamed = "󱀱",
              untracked = "󰻭",
              deleted = "󱀷",
              ignored = "󰷇",
            },
          },
          show = {
            modified = true,
          },
        },
      },
      view = { adaptive_size = true },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        -- Important: When you supply an `on_attach` function, nvim-tree won't
        -- automatically set up the default keymaps. To set up the default keymaps,
        -- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local preview = require('nvim-tree-preview')

        vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
        vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
        vim.keymap.set('n', '<C-f>', function() return preview.scroll(4) end, opts 'Scroll Down')
        vim.keymap.set('n', '<C-b>', function() return preview.scroll(-4) end, opts 'Scroll Up')

        -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
        vim.keymap.set('n', '<Tab>', function()
          local ok, node = pcall(api.tree.get_node_under_cursor)
          if ok and node then
            if node.type == 'directory' then
              api.node.open.edit()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end, opts 'Preview')

        -- Option B: Simple tab behavior: Always preview
        -- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
      end,
    })

    -- Set custom colors for Git icons in nvim-tree
    vim.api.nvim_set_hl(0, "NvimTreeGitDirtyIcon", { fg = "#dcc193" })   -- Modified filesNvimTreeGitIcon
    vim.api.nvim_set_hl(0, "NvimTreeGitNewIcon", { fg = "#88c796" })     -- New files
    vim.api.nvim_set_hl(0, "NvimTreeGitDeletedIcon", { fg = "#944a3a" }) -- Deleted files
    vim.api.nvim_set_hl(0, "NvimTreeGitRenamedIcon", { fg = "#88c796" }) -- Renamed/moved files
  end,
}
