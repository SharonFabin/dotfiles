return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        options = {
          modules = { -- List of various plugins and additional options
            -- ...
            nvimtree = {
              enabled = true,
              show_root = true,
            },
          },
          darken = {
            floats = false,
          },
        },
        palettes = {
          -- Custom duskfox with black background
          all = {
            bg1 = "#ff0000", -- Black background
            bg0 = "#ff0000", -- Alt backgrounds (floats, statusline, ...)
            bg3 = "#ff0000", -- 55% darkened from stock
            sel0 = "#ff0000", -- 55% darkened from stock
          },
        },
      })

      vim.cmd("colorscheme github_dark_default")

      -- neovim 10 colors
      vim.cmd("highlight @keyword guifg=#FF7B72") -- Red color for keywords
      vim.cmd("highlight @include guifg=#FF7B72") -- Red color for imports
      vim.cmd("highlight @module guifg=#C9D1D9") -- Light gray for module names
      vim.cmd("highlight @variable guifg=#C9D1D9")

      vim.cmd("highlight CursorLine cterm=NONE ctermbg=236 guibg=#24292F")
      vim.cmd("highlight NeoTreeNormal guibg=#090D12 guifg=#C0C0B8 ctermbg=234")
      vim.cmd("highlight NeoTreeFileName guifg=#C0C0B8 ctermbg=234")
      vim.cmd("highlight NeoTreeGitUntracked guifg=#D96A70 ctermbg=234")
      vim.cmd("highlight MiniIndentscopeSymbol guifg=#C19EEB ctermbg=234")
      vim.cmd("highlight DiagnosticHint guifg=#C19EEB ctermbg=234")
      vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#C19EEB" })
    end,
  },
}
