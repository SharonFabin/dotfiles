return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = true,
      virtual_text = false,
      -- virtual_text = {
      --   -- enabled = false,
      --   -- spacing = 4,
      --   -- source = "if_many",
      --   -- prefix = "●",
      --   -- -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      --   -- -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      --   -- -- prefix = "icons",
      -- },
      severity_sort = true,
    },
    -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the inlay hints.
    inlay_hints = {
      enabled = false,
    },
  },
}
