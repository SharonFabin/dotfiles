return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>he",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
}
-- return {
--   {
--     "ThePrimeagen/harpoon",
--     branch = "harpoon2",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--     },
--     keys = {
--       {
--         "<leader>he",
--         function()
--           require("harpoon.ui").toggle_quick_menu()
--         end,
--         desc = "Harpoon List",
--       },
--       {
--         "<leader>ha",
--         function()
--           require("harpoon.mark").add_file()
--         end,
--         desc = "Harpoon Add File",
--       },
--       {
--         "<leader>1",
--         function()
--           require("harpoon.ui").nav_file(1)
--         end,
--         desc = "Harpoon File 1",
--       },
--       {
--         "<leader>2",
--         function()
--           require("harpoon.ui").nav_file(2)
--         end,
--         desc = "Harpoon File 2",
--       },
--       {
--         "<leader>3",
--         function()
--           require("harpoon.ui").nav_file(3)
--         end,
--         desc = "Harpoon File 3",
--       },
--       {
--         "<leader>4",
--         function()
--           require("harpoon.ui").nav_file(4)
--         end,
--         desc = "Harpoon File 4",
--       },
--     },
--   },
-- }
