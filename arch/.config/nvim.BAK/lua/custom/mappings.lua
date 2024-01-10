---@type MappingsTable
local M = {}

M.disabled = {
	n = {
		["<leader>x"] = "",
		["<leader>h"] = "",
		["<leader>fo"] = "",
	},
}

M.general = {
	n = {
		-- Telescope
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
		["gr"] = { "<cmd> Telescope lsp_references <CR>", "LSP References" },
		["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "LSP Definitions" },
		["<leader>fr"] = { "<cmd> Telescope oldfiles <CR>", "Recent Files" },

		-- Harpoon
		["<leader>he"] = {
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			"Harpoon List",
		},
		["<leader>ha"] = {
			function()
				require("harpoon.mark").add_file()
			end,
			"Harpoon Add File",
		},
		["<leader>1"] = {
			function()
				require("harpoon.ui").nav_file(1)
			end,
			"Harpoon File 1",
		},
		["<leader>2"] = {
			function()
				require("harpoon.ui").nav_file(2)
			end,
			"Harpoon File 2",
		},
		["<leader>3"] = {
			function()
				require("harpoon.ui").nav_file(3)
			end,
			"Harpoon File 3",
		},
		["<leader>4"] = {
			function()
				require("harpoon.ui").nav_file(4)
			end,
			"Harpoon File 4",
		},
		["<leader>e"] = {
			function()
				local api = require("nvim-tree.api")
				api.tree.toggle()
			end,
			"Toggle Nvim Tree",
		},

		-- LSP

		-- Undo
		["<leader>uu"] = { "<cmd> Telescope undo<CR>", "Undo Tree" },

		-- Toggle
		["<leader>uh"] = {
			function()
				vim.lsp.inlay_hint(0, nil)
			end,
			"Toggle Inlay Hints",
		},
		["<leader>uc"] = { "<cmd> Copilot toggle<CR> ", "Toggle Copilot" },

		-- Functions
		["<F2>"] = {
			function()
				require("nvchad.renamer").open()
			end,
			"LSP rename",
		},
		["U"] = { "<cmd>redo<CR>", "redo" },
	},
	i = {
		["<C-s>"] = { "<C-O>:w<CR>", "Save" },
	},
}

M.nvimtree = {
	plugin = true,

	n = {

		-- ["<F2>"] = {
		-- 	function()
		-- 		local api = require("nvim-tree.api")
		-- 		api.fs.rename()
		-- 	end,
		-- 	"Rename Nvimtree node",
		-- },
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
