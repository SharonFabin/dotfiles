local M = {}

M.opts = {
	modes = {
		search = {
			enabled = false,
		},
		char = {
			multi_line = false,
			highlight = { backdrop = false },
			char_actions = function(motion)
				return {
					[";"] = "next", -- set to `right` to always go right
					[","] = "prev", -- set to `left` to always go left
					[motion:lower()] = "",
					[motion:upper()] = "",
				}
			end,
		},
	},
}

return M
