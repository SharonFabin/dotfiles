-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set
map("n", "U", "<cmd> redo<CR>", { desc = "Redo" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<C-/>", "gc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n", "v" }, "<C-_>", "gc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n" }, "<C-/>", "gcc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n" }, "<C-_>", "gcc", { desc = "Toggle Comment", remap = true })
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<C-p>", LazyVim.pick("files"), { desc = "FZF" })
