local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"scss",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"c_sharp",
		"markdown",
		"markdown_inline",
		"python",
	},
	indent = {
		enable = true,
	},
	autotag = { enable = true },
	autopairs = { enable = true },
	context_commentstring = { enable = true },
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",
		"eslint-lsp",

		-- c/cpp stuff
		"clangd",
		"clang-format",

		-- C# stuff
		"omnisharp",
		"csharpier",

		-- python
		"black",
		"pyright",
		"mypy",
		"ruff",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
	},
}

M.telescope = {
	defaults = {
		extensions_list = {},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			undo = {
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = {
					preview_height = 0.8,
				},
			},
		},
		path_display = { "truncate" },
		color_devicons = true,
	},
}

M.copilot = {
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<TAB>",
		},
	},
}

return M
