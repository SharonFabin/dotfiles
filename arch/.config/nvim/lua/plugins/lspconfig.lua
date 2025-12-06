return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      underline = {
        severity = { min = vim.diagnostic.severity.WARN },
      },
      update_in_insert = true,
      virtual_text = {
        spacing = 4, -- Space between text and virtual text
        source = "if_many", -- Show source if multiple sources
        -- prefix = "●", -- Icon before the message
        prefix = "🤦",
        severity = { -- Show only specific severities
          vim.diagnostic.severity.ERROR,
        },
        format = function(diagnostic) -- Custom formatting
          return string.format("%s (%s)", diagnostic.message, diagnostic.source)
        end,
      },
      severity_sort = true,
    },
    inlay_hints = {
      enabled = false,
    },
    servers = {
      pyright = {
        init_options = {
          completion = {
            triggerCharacters = { "." },
          },
        },
        settings = {
          pyright = {
            disableOrganizeImports = false,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
        capabilities = {
          textDocument = {
            completion = {
              completionItem = { snippetSupport = false },
              triggerCharacters = { ".", "(", '"', "'", "[", "@", " " },
            },
          },
        },
      },
      ruff = {
        keys = {
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
        },
      },
    },
    setup = {
      ruff = function()
        LazyVim.lsp.on_attach(function(client, _)
          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
      tailwindcss = function(_, opts)
        opts.filetypes = opts.filetypes or {}

        -- NEW API: Use vim.lsp.config instead of LazyVim.lsp.get_raw_config
        vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

        -- Remove excluded filetypes
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)

        -- Additional settings for Phoenix projects
        opts.settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
            experimental = {
              classRegex = {
                { "cva(((?:[^()]|([^()]*))*))", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx(((?:[^()]|([^()]*))*))", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              },
            },
          },
        }

        -- Add additional filetypes
        vim.list_extend(opts.filetypes, opts.filetypes_include or {})
      end,
    },
  },
}
