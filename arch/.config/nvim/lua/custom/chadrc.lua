---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "ayu_dark",
	theme_toggle = { "ayu_dark", "one_light" },
	hl_override = highlights.override,
	hl_add = highlights.add,
	-- statusline = {
	-- 	overriden_modules = function(modules)
	-- 		table.insert(
	-- 			modules,
	-- 			7,
	-- 			(function()
	-- 				return require("copilot_status").status_string()
	-- 			end)()
	-- 		)
	-- 	end,
	-- },
	nvdash = {
		load_on_startup = true,
		header = {
			"           ▄ ▄                   ",
			"       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
			"       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
			"    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
			"  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
			"  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
			"▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
			"█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
			"    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
			--     "                                 ",
			--     "            Pojok Code           ",
		},
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
