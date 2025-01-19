-- return {
--   "nvim-neo-tree/neo-tree.nvim",
--   opts = {
--     window = {
--       width = 30,
--     },
--     default_component_configs = {
--       icon = {
--         folder_closed = "",
--         folder_open = "",
--       },
--     },
--
--   },
-- }
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    -- Set the static options first
    opts.window = {
      width = 30,
    }
    opts.default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
      },
    }

    -- Add the file rename handling
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    return opts
  end,
}
