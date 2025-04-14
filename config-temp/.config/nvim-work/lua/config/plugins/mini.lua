return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local MiniStatusline = require('mini.statusline')

      local function wrap_section(icon, content)
        content = content and content:match("^%s*(.-)%s*$") or "" -- Trim inline
        return #content > 0 and (icon .. "( " .. content .. " )") or ""
      end

      -- Define custom highlight groups with 'MyMiniStatusline' prefix
      vim.cmd([[
        highlight MyMiniStatuslineError guifg=#c53b53 guibg=#3b4261 gui=bold
        highlight MyMiniStatuslineWarn  guifg=#ffc777 guibg=#3b4261 gui=bold
        highlight MyMiniStatuslineInfo  guifg=#0db9d7 guibg=#3b4261 gui=bold
        highlight MyMiniStatuslineHint  guifg=#4fd6be guibg=#3b4261 gui=bold
      ]])

      vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticHint' })
      -- Custom diagnostic signs with new highlight groups
      local diag_signs = {
        ERROR = '%#MyMiniStatuslineError#%#MiniStatuslineDevinfo#',
        WARN  = '%#MyMiniStatuslineWarn#%#MiniStatuslineDevinfo#',
        INFO  = '%#MyMiniStatuslineInfo#󰚚%#MiniStatuslineDevinfo#',
        HINT  = '%#MyMiniStatuslineHint#%#MiniStatuslineDevinfo#',
      }

      local my_active_content = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 3 })
        local git           = MiniStatusline.section_git({ trunc_width = 40 })
        local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics   = MiniStatusline.section_diagnostics({
          trunc_width = 75,
          signs = diag_signs,
          use_icons = false,
          icon = ''
        })
        local lsp           = MiniStatusline.section_lsp({ trunc_width = 75, icon = '' })
        local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
        local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location      = MiniStatusline.section_location({ trunc_width = 75 })
        local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

        -- Explicitly wrap sections
        diagnostics         = wrap_section("󰅏", diagnostics)
        lsp                 = wrap_section("󱪚", lsp)

        return MiniStatusline.combine_groups({
          { hl = mode_hl,                 strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
          '%<', -- Mark general truncate point
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- End left alignment
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl,                  strings = { search, location } },
        })
      end
      MiniStatusline.setup({
        use_icons = true,
        content = { active = my_active_content }
      })
    end
  }
}
