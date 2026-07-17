local status_ok, claude = pcall(require, "claudecode")
if not status_ok then
	print("claude did not load.")
	return
end

claude.setup({
	terminal = {
		split_side = "right",
		split_width_percentage = 0.3,
	},
})

-- Toggle & focus
vim.keymap.set("n", "<M-a>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude", noremap = true, silent = false })
vim.keymap.set("t", "<M-a>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude", noremap = true, silent = false })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude", noremap = true, silent = true })

-- Session management
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude", noremap = true, silent = true })
vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude", noremap = true, silent = true })
vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model", noremap = true, silent = true })

-- Context sharing
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer", noremap = true, silent = true })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude", noremap = true, silent = true })

-- Diff management
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff", noremap = true, silent = true })
