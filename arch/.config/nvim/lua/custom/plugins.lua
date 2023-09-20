local overrides = require("custom.configs.overrides")
local flash = require("custom.configs.flash")

local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "windwp/nvim-ts-autotag" },
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
			},
		},
		opts = overrides.treesitter,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
		lazy = false,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				char = "│",
				filetype_exclude = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				show_trailing_blankline_indent = false,
				show_current_context = false,
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},
	{
		"prochri/telescope-all-recent.nvim",
		config = function()
			require("telescope-all-recent").setup({
				-- your config goes here
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			{
				"prochri/telescope-all-recent.nvim",
				dependencies = { "kkharji/sqlite.lua" },
			},
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = overrides.telescope,
		config = function(_, opts)
			require("telescope").load_extension("fzf")
			require("telescope").setup(opts)
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = "CursorHold",
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",

		opts = flash.opts,
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump({
          highlight = {}
        }) end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	{
		"mg979/vim-visual-multi",
		-- lazy = false,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			create_autocmd = false,
		},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		-- Lazy load when event occurs. Events are triggered
		-- as mentioned in:
		-- https://vi.stackexchange.com/a/4495/20389
		event = "InsertEnter",
		-- You can also have it load at immediately at
		-- startup by commenting above and uncommenting below:
		-- lazy = false
		opts = overrides.copilot,
	},
	-- {
	-- 	"jonahgoldwastaken/copilot-status.nvim",
	-- 	dependencies = { "zbirenbaum/copilot.lua" }, -- or "zbirenbaum/copilot.luFa"
	-- 	lazy = true,
	-- 	event = "BufReadPost",
	-- },
	{
		"sourcegraph/sg.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Need to remove!!
}
return plugins
