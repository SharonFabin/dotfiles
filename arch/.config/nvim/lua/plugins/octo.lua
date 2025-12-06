return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  config = function()
    require("octo").setup()
  end,
  keys = {
    { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List Issues (Octo)" },
    { "<leader>gI", "<cmd>Octo issue search<cr>", desc = "Search Issues (Octo)" },
    { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs (Octo)" },
    { "<leader>gP", "<cmd>Octo pr search<cr>", desc = "Search PRs (Octo)" },
    { "<leader>gr", "<cmd>Octo repo list<cr>", desc = "List Repos (Octo)" },
  },
}
