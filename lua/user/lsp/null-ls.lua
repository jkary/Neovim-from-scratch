local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			extra_args = {
				"--no-semi",
				"--single-quote",
				"--jsx-single-quote",
				"--print-width",
                "-w",
				"88",
			},
			filetypes = { "html", "json", "yaml", "markdown", "toml", "html" },
			disabled_filetypes = { "typescript", "javascript", "javascriptreact", "lua", "go", "python" },
		}),
		formatting.codespell,
		-- formatting.isort,
		-- formatting.black.with({ extra_args = { "--fast" } }),
		-- formatting.styelua,
		-- diagnostics.flake8,
		code_actions.refactoring,
	},
})
