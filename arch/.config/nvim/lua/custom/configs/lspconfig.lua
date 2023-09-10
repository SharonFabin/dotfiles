local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "tailwindcss" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})

lspconfig.tailwindcss.setup({})

-- lspconfig.tsserver.settings = {
--   typescript = {
--     inlayHints = {
--       includeInlayParameterNameHints = "all",
--       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--       includeInlayFunctionParameterTypeHints = true,
--       includeInlayVariableTypeHints = false,
--       includeInlayPropertyDeclarationTypeHints = true,
--       includeInlayFunctionLikeReturnTypeHints = false,
--       includeInlayEnumMemberValueHints = true,
--     },
--     suggest = {
--       includeCompletionsForModuleExports = true,
--     },
--   },
--   javascript = {
--     inlayHints = {
--       includeInlayParameterNameHints = "all",
--       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--       includeInlayFunctionParameterTypeHints = true,
--       includeInlayVariableTypeHints = false,
--       includeInlayPropertyDeclarationTypeHints = true,
--       includeInlayFunctionLikeReturnTypeHints = false,
--       includeInlayEnumMemberValueHints = true,
--     },
--     suggest = {
--       includeCompletionsForModuleExports = true,
--     },
--   },
-- }

--
-- lspconfig.pyright.setup { blabla}
