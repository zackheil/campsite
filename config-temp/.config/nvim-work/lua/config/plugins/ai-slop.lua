return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua", branch = "beta" },
      { "nvim-lua/plenary.nvim",  branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken",                           -- Only on MacOS or Linux
    config = function()
      vim.opt.splitright = true

      require("copilot").setup({
        suggestion = {
          auto_trigger = true
        }
      })


      require("CopilotChat").setup({
        model = "gpt-4o",
        mappings = {
          reset = false,
          complete = false,
        },
        window = {
          width = 0.25
        },
        auto_insert_mode = true,
      })

      -- Normal mode keymap
      vim.keymap.set("n", "<leader>cpc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })

      -- Visual mode keymaps
      vim.keymap.set("v", "<leader>cpc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })
      vim.keymap.set("v", "<leader>cpe", ":CopilotChatExplain<CR>", { desc = "Explain code" })
      vim.keymap.set("v", "<leader>cpr", ":CopilotChatReview<CR>", { desc = "Review code" })
      vim.keymap.set("v", "<leader>cpf", ":CopilotChatFix<CR>", { desc = "Fix code" })
      vim.keymap.set("v", "<leader>cpo", ":CopilotChatOptimize<CR>", { desc = "Optimize code" })
      vim.keymap.set("v", "<leader>cpd", ":CopilotChatDocs<CR>", { desc = "Generate documentation" })
      vim.keymap.set("v", "<leader>cpt", ":CopilotChatTest<CR>", { desc = "Generate test" })
      vim.keymap.set("v", "<leader>cpr", ":CopilotChatRename<CR>", { desc = "Rename variable" })
    end
  }
}
