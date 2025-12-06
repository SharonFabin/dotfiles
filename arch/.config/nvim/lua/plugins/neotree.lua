return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 30,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<space>"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
      },
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      git_status = {
        symbols = {
          unstaged = "󰄱",
          staged = "󰱒",
        },
      },
    },
  },
}
-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = function(_, opts)
--     -- Set the static options first
--     opts.window = {
--       width = 30,
--     }
--     opts.default_component_configs = {
--       icon = {
--         folder_closed = "",
--         folder_open = "",
--       },
--     }
--
--     -- Add the file rename handling
--     local function on_move(data)
--       Snacks.rename.on_rename_file(data.source, data.destination)
--     end
--     local events = require("neo-tree.events")
--     opts.event_handlers = opts.event_handlers or {}
--     vim.list_extend(opts.event_handlers, {
--       { event = events.FILE_MOVED, handler = on_move },
--       { event = events.FILE_RENAMED, handler = on_move },
--     })
--
--     return opts
--   end,
-- }
