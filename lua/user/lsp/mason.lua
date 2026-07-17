local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	vim.notify("mason.nvim is not loaded", vim.log.levels.WARN)
	return
end

local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
	vim.notify("mason-lspconfig.nvim is not loaded", vim.log.levels.WARN)
	return
end

local handlers = require("user.lsp.handlers")
local base_config = {
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

local servers = {
	lua_ls = "user.lsp.settings.luals",
	pylsp = "user.lsp.settings.python_lsp_server",
	ruff = "user.lsp.settings.ruff",
	gopls = "user.lsp.settings.golang",
	golangci_lint_ls = nil,
	jsonls = "user.lsp.settings.jsonls",
	ansiblels = "user.lsp.settings.ansible",
}

for server, settings_module in pairs(servers) do
	local config = vim.tbl_deep_extend("force", {}, base_config)

	if settings_module then
		local ok, settings = pcall(require, settings_module)
		if ok then
			config = vim.tbl_deep_extend("force", config, settings)
		else
			vim.notify(("Unable to load LSP settings for %s: %s"):format(server, settings), vim.log.levels.WARN)
		end
	end

	vim.lsp.config(server, config)
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lsp.setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_enable = vim.tbl_keys(servers),
})
