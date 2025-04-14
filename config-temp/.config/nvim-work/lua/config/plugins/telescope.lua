return {
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
          },
          fzf = {}
        }
      })

      local telescope_builtin = require("telescope.builtin")
      local custom = require("config.telescope.multigrep")

      telescope.load_extension("ui-select")

      vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', custom.live_multigrep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

      vim.keymap.set('n', '<leader>fws', function()
        local cursor = vim.api.nvim_win_get_cursor(0) -- Save cursor position
        vim.cmd("normal! b")                          -- Move to beginning of the word
        local word = vim.fn.expand("<cword>")         -- Get full word
        vim.api.nvim_win_set_cursor(0, cursor)        -- Restore cursor position
        telescope_builtin.grep_string({ search = word })
      end, { desc = 'Telescope find word (smart)' })

      vim.keymap.set('n', '<leader>fWs', function()
        local cursor = vim.api.nvim_win_get_cursor(0) -- Save cursor position
        vim.cmd("normal! b")                          -- Move to beginning of the word
        local word = vim.fn.expand("<cWORD>")         -- Get full word
        vim.api.nvim_win_set_cursor(0, cursor)        -- Restore cursor position
        telescope_builtin.grep_string({ search = word })
      end, { desc = 'Telescope find WORD (smart)' })
    end
  },
  {
  }
}
