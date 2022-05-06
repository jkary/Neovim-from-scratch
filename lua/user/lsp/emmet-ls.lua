local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	print("lspconfig_status_ok failed.")
	return
end

local configs_status_ok, configs = pcall(require, "lspconfig/configs")
if not configs_status_ok then
	print("configs_status_ok failed.")
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not configs.ls_emmet then
	configs.ls_emmet = {
		default_config = {
			cmd = { "ls_emmet", "--stdio" },
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"haml",
				"xml",
				"xsl",
				"pug",
				"slim",
				"sass",
				"stylus",
				"less",
				"sss",
			},
		},
	}
end
lspconfig.emmet_ls.setup({ capabilities = capabilities })
