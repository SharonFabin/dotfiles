return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        palettes = {
          -- Custom duskfox with black background
          github_dark = {
            -- bg1 = "#000000", -- Black background
            bg1 = "#ff1820", -- 55% darkened from stock
            bg2 = "#ff1820", -- 55% darkened from stock
            -- bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
            -- bg3 = "#121820", -- 55% darkened from stock
            bg0 = "#ff1820", -- 55% darkened from stock
            bg3 = "#ff1820", -- 55% darkened from stock
            -- sel0 = "#ff1820", -- 55% darkened from stock
            -- sel0 = "#131b24", -- 55% darkened from stock
          },
        },
        specs = {
          all = {
            inactive = "bg0", -- Default value for other styles
          },
          github_dark_dimmed = {
            -- inactive = "#090909", -- Slightly lighter then black background
            inactive = "#ff0000", -- Slightly lighter then black background
          },
        },
        groups = {
          all = {
            Normal = { fg = "#e6edf3", bg = "#0d1117" }, -- Non-current windows
            NormalNC = { fg = "#e6edf3", bg = "#0d1117" }, -- Non-current windows
            CursorLine = { bg = "#25282E" },
            StatusLine = { bg = "#ff0000" },
            -- NEOTreeNormal = { bg = "#000000" },
            -- NEOTreeNormalNC = { bg = "#000000" },
          },
        },
      })
      -- vim.cmd([[colorscheme github_dark_tritanopia]])
      vim.cmd([[colorscheme github_dark]])
      vim.cmd("hi NEOTreeNormal guibg=#040406")
      vim.cmd("hi NEOTreeNormalNC guibg=#040406")
    end,
  },

  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "github_dark_high_contrast",
  --   },
  -- },
}
