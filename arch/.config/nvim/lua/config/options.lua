-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd([[
hi DiagnosticUnderlineError gui=undercurl
hi DiagnosticUnderlineWarn gui=undercurl
hi DiagnosticUnderlineHint gui=undercurl
set termguicolors
]])

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  severity_sort = true,
  update_in_insert = true,
})
