local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
	print("Harpoon did not load.")
	return
end

-- Detect OS
local is_mac = vim.fn.has("macunix") == 1
local is_linux = vim.fn.has("unix") == 1 and not is_mac
local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<C-e>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
vim.keymap.set("n", "<leader>gc", function()
	require("snacks").picker.git_branches()
end, { desc = "Git branches", silent = true, noremap = true })
if is_mac then
	-- These functions are stored in harpoon.  A plugn that I am developing
	vim.keymap.set("n", "<leader>a", "v:lua require('harpoon.mark').add_file()<CR>", opts)
	-- vim.keymap.set("n", "<C-a>", "v:lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
	vim.keymap.set("n", "¡", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
	vim.keymap.set("n", "™", "v:lua require('harpoon.ui').nav_file(2)<CR>", opts)
	vim.keymap.set("n", "£", "v:lua require('harpoon.ui').nav_file(3)<CR>", opts)
	vim.keymap.set("n", "¢", "v:lua require('harpoon.ui').nav_file(4)<CR>", opts)
	vim.keymap.set("n", "<leader>tu", "v:lua require('harpoon.term').gotoTerminal(1)<CR>", opts)
	vim.keymap.set("n", "<leader>te", "v:lua require('harpoon.term').gotoTerminal(2)<CR>", opts)
	vim.keymap.set("n", "<leader>cu", "v:lua require('harpoon.term').sendCommand(1, 1)<CR>", opts)
	vim.keymap.set("n", "<leader>ce", "v:lua require('harpoon.term').sendCommand(1, 2)<CR>", opts)
elseif is_linux then
	-- These functions are stored in harpoon.  A plugn that I am developing
	vim.keymap.set("n", "<leader>a", "v:lua require('harpoon.mark').add_file()<CR>", opts)
	vim.keymap.set("n", "<C-a>", "v:lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
	vim.keymap.set("n", "<A-1>", "v:lua require('harpoon.ui').nav_file(1)<CR>", opts)
	vim.keymap.set("n", "<A-2>", "v:lua require('harpoon.ui').nav_file(2)<CR>", opts)
	vim.keymap.set("n", "<A-3>", "v:lua require('harpoon.ui').nav_file(3)<CR>", opts)
	vim.keymap.set("n", "<A-4>", "v:lua require('harpoon.ui').nav_file(4)<CR>", opts)
	vim.keymap.set("n", "<leader>tu", "v:lua require('harpoon.term').gotoTerminal(1)<CR>", opts)
	vim.keymap.set("n", "<leader>te", "v:lua require('harpoon.term').gotoTerminal(2)<CR>", opts)
	vim.keymap.set("n", "<leader>cu", "v:lua require('harpoon.term').sendCommand(1, 1)<CR>", opts)
	vim.keymap.set("n", "<leader>ce", "v:lua require('harpoon.term').sendCommand(1, 2)<CR>", opts)
end

-- Remaps for each of the four debug operations currently offered by the plugin
vim.api.nvim_set_keymap(
	"v",
	"<Leader>re",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"v",
	"<Leader>rf",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"v",
	"<Leader>rv",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"v",
	"<Leader>ri",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ri",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
