local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	b.formatting.prettier.with({
		disabled_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	}),
	b.diagnostics.eslint,
	b.code_actions.eslint,
	-- b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

	-- Lua
	b.formatting.stylua,

	-- cpp
	b.formatting.clang_format,

	-- python
	b.formatting.black,
	b.diagnostics.ruff,
	b.diagnostics.mypy,

	-- Extra
	b.diagnostics.cspell.with({

		diagnostics_postprocess = function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity.HINT
		end,
	}),
	b.code_actions.cspell.with({
		config = {
			find_json = function(cwd)
				return vim.fn.expand(cwd .. "/cspell.json")
			end,
		},
	}),
}

null_ls.setup({
	debug = true,
	sources = sources,

	-- format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
})
