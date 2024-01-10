return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
      api_key_cmd = "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",
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo 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",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
