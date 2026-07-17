local M = {}

local icons = require("user.icons")

function M.setup()
	if not vim.api.nvim_get_commands({})["LspInfo"] then
		vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
			desc = "Show native LSP health and active clients",
		})
	end

	vim.diagnostic.config({
		virtual_text = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
				[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
				[vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
				[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
			},
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			border = "rounded",
			focusable = false,
			source = "if_many",
		},
	})

	vim.api.nvim_create_user_command("Format", function(args)
		local conform_ok, conform = pcall(require, "conform")
		if conform_ok then
			conform.format({
				async = args.bang,
				lsp_format = "fallback",
				timeout_ms = 3000,
			})
			return
		end

		vim.lsp.buf.format({ async = args.bang })
	end, { bang = true, desc = "Format current buffer" })
end

local function lsp_highlight_document(client)
	local illuminate_ok, illuminate = pcall(require, "illuminate")
	if illuminate_ok then
		illuminate.on_attach(client)
	end
end

local function lsp_keymaps(bufnr)
	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
	end

	map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
	map("n", "gd", vim.lsp.buf.definition, "Go to definition")
	map("n", "K", vim.lsp.buf.hover, "Hover")
	map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
	map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
	map("n", "gr", vim.lsp.buf.references, "References")
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
	map("n", "<leader>f", vim.diagnostic.open_float, "Line diagnostics")
	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, "Previous diagnostic")
	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, "Next diagnostic")
	map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
	map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to loclist")
	map("n", "<leader>F", "<cmd>Format<cr>", "Format buffer")
end

function M.on_attach(client, bufnr)
	if client.name == "tsserver" or client.name == "ts_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
else
	M.capabilities = capabilities
end

return M
