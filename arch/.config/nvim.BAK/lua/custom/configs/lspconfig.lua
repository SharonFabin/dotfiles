local os = require("os")
local omnisharp_server_location = os.getenv("OMNISHARP_LANGUAGE_SERVER")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "tailwindcss" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		-- flags = {
		-- 	debounce_text_changes = 150,
		-- },
	})
end

-- This is updated from .../nvim/lua/plugins.lua (NvChad default config)
-- I've added the hints config and everything else is copied from the original
-- If there is an update, check the original NvChad config to update this config
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		Lua = {
			hint = { enable = true },
			diagnostics = {
				-- globals = { "vim" },
				globals = {},
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})

lspconfig.tailwindcss.setup({})

lspconfig.omnisharp.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "cs", "csx" },
	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
})
--austin

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	severity_sort = true,
	update_in_insert = true,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
			suggest = {
				includeCompletionsForModuleExports = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
			suggest = {
				includeCompletionsForModuleExports = true,
			},
		},
	},
})

--
-- lspconfig.pyright.setup { blabla}
