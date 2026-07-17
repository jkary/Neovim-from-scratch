local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function(event)
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = event.buf,
			silent = true,
			desc = "Close window",
		})
		vim.bo[event.buf].buflisted = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd("CmdWinEnter", {
	group = augroup,
	callback = function()
		vim.cmd("quit")
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup,
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 500 })
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = augroup,
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})
