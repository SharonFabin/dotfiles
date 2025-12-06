return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
    "zbirenbaum/copilot.lua", -- Required for Copilot integration
  },
  opts = {
    -- anthropic = {
    --   auth_type = "api_key",
    --   api_key = "",
    --   model = "claude-3-7-sonnet-20250219", -- Claude Sonnet 3.7 model
    -- },
    -- adapter = "anthropic",
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
          make_vars = true, -- make chat #variables from MCP server resources
          make_slash_commands = true, -- make /slash_commands from MCP server prompts
        },
      },
    },
  },
}
