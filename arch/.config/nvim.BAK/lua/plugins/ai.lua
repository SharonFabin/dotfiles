local home = vim.fn.expand("$HOME")
return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "cat " .. home .. "/Documents/openai-key.txt",
        openai_params = {
          model = "gpt-4-1106-preview",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = "gpt-4-1106-preview",
          frequency_penalty = 0,
          presence_penalty = 0,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>ai",
        mode = { "v" },
        function()
          require("chatgpt").edit_with_instructions()
        end,
        desc = "AI Code Chat",
      },

      {
        "<leader>ai",
        mode = { "n" },
        function()
          require("chatgpt").openChat()
        end,
        desc = "AI Chat",
      },
    },
  },
}
