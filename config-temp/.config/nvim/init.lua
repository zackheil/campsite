-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
if not vim.g.mapleader then
  vim.g.mapleader = " "
end

if not vim.g.maplocalleader then
  vim.g.maplocalleader = " "
end

vim.env.GIT_SSH_COMMAND = 'ssh -F /Users/zheil/.local/share/git/auth-work-ssh-config'

require("config.lazy")

-- kickstart says this improves startup time
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- tab indent behavior (use spaces, convert tabs to spaces, use 4 by default)
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- vim.opt.autochdir = true

vim.g.have_nerd_font = true

-- don't show the current vim mode since it is in the status line plugin too
vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)

-- quickfix list navigation
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


vim.keymap.set('n', '<leader>tl', function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
  end
end, { desc = "Toggle between relative and absolute line numbers" })
