---@type MappingsTable
local M = {}

M.disabled = {
	n = {
		["<leader>x"] = "",
	},
}

M.general = {
	n = {
		-- ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Telescope Files" },
		["<C-p>"] = {
			function()
				require("telescope.builtin").find_files({
					-- cwd = require("lazy.core.config").options.root,
					sort_lastused = true,
				})
			end,
			"Telescope Files",
		},
		["<leader>/"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		-- ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Nvim Tree" },
		["<leader>e"] = {
			function()
				local api = require("nvim-tree.api")
				api.tree.toggle()
			end,
			"Toggle Nvim Tree",
		},
		["<F2>"] = {
			function()
				require("nvchad.renamer").open()
			end,
			"LSP rename",
		},
	},
	i = {
		["<C-s>"] = { "<C-O>:w<CR>", "Save" },
	},
}

M.nvimtree = {
	plugin = true,

	n = {

		["<F2>"] = {
			function()
				local api = require("nvim-tree.api")
				api.fs.rename()
			end,
			"Rename Nvimtree node",
		},
		-- toggle
		-- ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

		-- focus
		-- ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
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
