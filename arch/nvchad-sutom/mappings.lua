---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>x"] = "",
  },
}

M.general = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Telescope Files" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Nvim Tree" },
  },
}

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<c-/>", "gc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n", "v" }, "<c-_>", "gc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n" }, "<c-/>", "gcc", { desc = "Toggle Comment", remap = true })
vim.keymap.set({ "n" }, "<c-_>", "gcc", { desc = "Toggle Comment", remap = true })

-- more keybinds!

return M
