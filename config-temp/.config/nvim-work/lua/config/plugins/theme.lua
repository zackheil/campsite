return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- style = "night", -- Ensure "night" or "storm"
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight") -- Ensure it loads on startup
    end,
  }
}
