local M = {
  "nvim-telescope/telescope.nvim",
  version = "0.1.0",
  cmd = { "Telescope" },
  lazy = false,

  keys = {
    -- disable the keymap to grep files
    -- { "<leader>/", false },
    -- change a keymap
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({
          cwd = require("lazy.core.config").options.root,
          sort_lastused = true,
        })
      end,
      desc = "Find Plugin File",
    },
  },
  dependencies = {
    "kkharji/sqlite.lua",
    { "prochri/telescope-all-recent.nvim", opts = {} },
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "natecraddock/telescope-zf-native.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "aaronhallaert/advanced-git-search.nvim",
  },
}

M.config = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local trouble_ok, trouble = pcall(require, "trouble.providers.telescope")
  if not trouble_ok then
    return
  end

  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local layout_actions = require("telescope.actions.layout")
  local lga_actions = require("telescope-live-grep-args.actions")

  telescope.setup({
    defaults = {
      set_env = {
        LESS = "",
        DELTA_PAGER = "less",
        COLORTERM = "truecolor",
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--fixed-strings",
        "--trim",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      mappings = {
        i = {
          ["<c-t>"] = trouble.open_with_trouble,
          ["<c-h>"] = layout_actions.toggle_preview,
          ["<C-b>"] = actions.results_scrolling_down,
          ["<C-f>"] = actions.results_scrolling_up,
          ["<CR>"] = actions.select_default,
          ["<c-u>"] = actions.preview_scrolling_up,
          ["<c-d>"] = actions.preview_scrolling_down,
          ["<c-q>"] = actions.delete_buffer,
          ["<c-space>"] = layout_actions.cycle_layout_next,
          ["<c-e>"] = actions.to_fuzzy_refine,
        },
        n = {
          ["q"] = actions.delete_buffer,
          ["<c-t>"] = trouble.open_with_trouble,
          ["<c-h>"] = layout_actions.toggle_preview,
          ["<C-b>"] = actions.results_scrolling_down,
          ["<C-f>"] = actions.results_scrolling_up,
          ["<c-u>"] = actions.preview_scrolling_up,
          ["<c-d>"] = actions.preview_scrolling_down,
          ["<c-space>"] = layout_actions.cycle_layout_next,
          ["<c-e>"] = actions.to_fuzzy_refine,
          ["<CR>"] = actions.select_default,
        },
      },
      cycle_layout_list = { "flex", "horizontal" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      path_display = { "truncate" },
      get_status_text = function()
        return ""
      end,
      preview = {
        filesize_limit = 3,
        timeout = 250,
      },
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      scroll_strategy = "limit",
      color_devicons = true,
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.95,
        height = 0.85,
        prompt_position = "top",
        horizontal = {
          preview_width = function(_, cols, _)
            return math.floor(cols * 0.4)
          end,
        },
        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.55,
        },
        flex = {
          horizontal = {
            preview_width = 0.7,
          },
        },
      },
      file_ignore_patterns = {
        "^.vim/",
        "^.local/",
        "^.cache/",
        "^Downloads/",
        "^.git/",
        "^Dropbox/",
        "^Library/",
        "^undodir/",
        "^plugged/",
        "^sessions/",
        "^node_modules/",
        "^.yarn/",
      },
    },
    pickers = {
      live_grep_args = {
        disable_coordinates = true,
        layout_config = {
          horizontal = {
            preview_width = 0.8,
          },
        },
      },
      advanced_git_search = {
        layout_config = {
          horizontal = {
            preview_width = 0.8,
          },
        },
      },
    },
    extensions = {
      ["zf-native"] = {
        file = {
          enable = true,
          highlight_results = true,
          -- enable zf filename match priority
          match_filename = true,
        },
        generic = {
          enable = true,
          highlight_results = true,
          match_filename = false,
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
      live_grep_args = {
        disable_coordinates = true,
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = {
          -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-r>"] = function(prompt_bufnr)
              local picker = action_state.get_current_picker(prompt_bufnr)
              local prompt = picker:_get_prompt()
              picker:set_prompt("--no-fixed-strings " .. prompt)
            end,
          },
        },
        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
        },
      },
      advanced_git_search = {
        git_flags = { "-c", "delta.side-by-side=false", "-c", "core.pager=delta", "-c", "delta.pager='less -RS'" },
        git_diff_flags = {},
        show_builtin_git_pickers = true,
        diff_plugin = "diffview",
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
    },
  })

  telescope.load_extension("zf-native")
  telescope.load_extension("ui-select")
  telescope.load_extension("live_grep_args")
  telescope.load_extension("advanced_git_search")
end

function M.project_files()
  local utils = require("telescope.utils")
  local _, ret, _ = utils.get_os_command_output({
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  })

  local themes = require("telescope.themes")
  local gopts = themes.get_dropdown({
    use_git_root = true,
    preview = { hide_on_startup = true },
    layout_config = {
      width = 0.65,
    },
    show_untracked = true,
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  })
  local fopts = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  }

  gopts.prompt_title = "Git Files"

  fopts.prompt_title = "Find Files"
  fopts.hidden = true

  if ret == 0 then
    require("telescope.builtin").git_files(gopts)
  else
    require("telescope.builtin").find_files(fopts)
  end
end

function M.file_explorer()
  require("telescope.builtin").file_browser({
    prompt_title = "File Browser",
    cwd = "~",
    layout_strategy = "horizontal",
  })
end

function M.lsp_definitions()
  require("telescope.builtin").lsp_definitions({})
end

function M.lsp_references()
  require("telescope.builtin").lsp_references({
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
    fname_width = 40,
  })
end

function M.buffers()
  local layout_config = require("telescope.themes").get_dropdown({
    layout_config = {
      width = 0.65,
    },
  }).layout_config

  require("telescope.builtin").buffers({
    prompt_title = "Open Buffers",
    preview = { hide_on_startup = true },
    sort_mru = true,
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    ignore_filename = false,
    bufnr_width = 0,
    layout_config = layout_config,
  })
end

function M.grep_current_dir()
  local buffer_dir = require("telescope.utils").buffer_dir()
  local opts = {
    prompt_title = "Live Grep in " .. buffer_dir,
    cwd = buffer_dir,
  }
  require("telescope.builtin").live_grep(opts)
end

return M
