-- return {
--   "utilyre/barbecue.nvim",
--   name = "barbecue",
--   dependencies = {
--     "SmiteshP/nvim-navic",
--     "nvim-tree/nvim-web-devicons",
--   },
--   ---@type barbecue.Config
--   opts = {
--     theme = "catppuccin",
--   },
-- }
return {
  "utilyre/barbecue.nvim",
  event = "BufReadPre",
  dependencies = {
    "folke/tokyonight.nvim",
    "SmiteshP/nvim-navic",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("barbecue").setup({
      attach_navic = false,
      show_navic = false,
      show_modified = true,
      theme = "tokyonight",
      symbols = {
        prefix = " ",
        separator = "",
        modified = "●",
        default_context = "…",
      },
    })
  end,
}
