-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<C-p>", "<leader>ff")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<c-/>", "gc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n", "v" }, "<c-_>", "gc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n" }, "<c-/>", "gcc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n" }, "<c-_>", "gcc", { desc = "Toggle Comment", remap = true })
