return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 30,
        },
        filesystem = {
          filtered_items = {
            visible = true,
          },
        },
      })
    end,
  },
}
