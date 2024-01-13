local function filename_without_filetype()
  local full_filename = vim.fn.expand("%:t")
  local filetype_start = full_filename:find(".%w+$")
  if filetype_start then
    return full_filename:sub(1, filetype_start - 1)
  else
    return full_filename
  end
end
local colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  violet = "#d183e8",
  grey = "#303030",
  cattpuccin_grey_bg = "#14171d",
  cattpuccin_grey_fg = "#5b5f71",
  cattpuccin_normal = "aeb7f4",
  cattpuccin_b_bg = "#262a30",
  cattpuccin_b_fg = "#c3ccd4",
  cattpuccin_c_fg = "#41a8d8",
  cattpuccin_y_bg = "#e099a4",
  cattpuccin_z_bg = "#e6c3c3",
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.cattpuccin_normal, gui = "bold" },
    b = { fg = colors.cattpuccin_b_fg, bg = colors.cattpuccin_b_bg },
    c = { fg = colors.cattpuccin_b_fg, bg = colors.cattpuccin_grey_bg, gui = "bold" },
    y = { fg = colors.black, bg = colors.cattpuccin_y_bg },
    z = { fg = colors.black, bg = colors.cattpuccin_z_bg },
  },

  insert = { a = { fg = colors.black, bg = colors.blue, gui = "bold" } },
  visual = { a = { fg = colors.black, bg = colors.cyan, gui = "bold" } },
  replace = { a = { fg = colors.black, bg = colors.red, gui = "bold" } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local Util = require("lazyvim.util")
      local icons = require("lazyvim.config").icons
      local colors = {
        [""] = Util.ui.fg("Special"),
        ["Normal"] = Util.ui.fg("Special"),
        ["Warning"] = Util.ui.fg("DiagnosticError"),
        ["InProgress"] = Util.ui.fg("DiagnosticWarn"),
      }

      opts.options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "NvimTree", "packer" },
        extensions = { "nvim-tree", "fzf" },
      }
      opts.sections = {
        lualine_a = {
          function()
            local mode_map = {
              n = "NORMAL",
              i = "INSERT",
              v = "VISUAL",
              [""] = "VISUAL BLOCK",
              V = "VISUAL LINE",
              c = "COMMAND",
              R = "REPLACE",
              s = "SELECT",
              t = "TERMINAL",
            }

            local mode = vim.api.nvim_get_mode().mode
            local mode_name = mode_map[mode] or mode
            return "󰕷 " .. mode_name
          end,
        },
        lualine_b = {
          {
            "filetype",
            colored = false, -- Displays filetype icon in color if set to true
            icon_only = true, -- Display only an icon for filetype
          },
          { "filename", padding = 0 },
        },
        lualine_c = {
          -- { "branch", icon = "" },
          { "branch", icon = "" },

          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.ui.fg("Debug"),
          },

          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
            padding = { left = 0, right = 1 },
          },
          { "copilot", padding = { left = 0, right = 2 } },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = Util.ui.fg("Special"),
            padding = { left = 0, right = 1 },
          },
        },

        lualine_y = {

          {
            color = { fg = "#1b1e24", bg = "#e56c73" },
            padding = 0,
            function()
              return " "
            end,
          },
          {
            color = { fg = "#b4bac4", bg = "#22262b" },

            function()
              local path = Util.root.cwd()
              return path:match("([^/]+)$")
            end,
          },
        },
        lualine_z = {

          {
            color = { fg = "#1b1e24", bg = "#a4d14c" },
            padding = 0,
            function()
              return "󰦨 "
            end,
          },
          {
            "location",
            padding = { left = 1, right = 0 },
            color = { fg = "#a4d14c", bg = "#22262b" },
          },
          {
            function()
              return " 󰟃 "
            end,

            color = { fg = "#a4d14c", bg = "#22262b" },
            padding = 0,
          },
          {
            "progress",
            padding = { left = 0, right = 1 },
            color = { fg = "#a4d14c", bg = "#22262b" },
          },
        },
      }
    end,
  },
}
