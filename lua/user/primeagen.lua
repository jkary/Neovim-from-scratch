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
vim.keymap.set("n", "<leader>gc", ":lua require('theprimeagen.telescope').git_branches()<CR>")
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
-- vim.cmd([[
-- nnoremap <leader>h :lua require("harpoon.mark").add_file()<CR>
-- nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
-- nnoremap <C-P> :lua require('telescope').extensions.project.project{}<CR>
-- nnoremap <A-1> :lua require("harpoon.ui").nav_file(1)<CR>
-- nnoremap <A-2> :lua require("harpoon.ui").nav_file(2)<CR>
-- nnoremap <A-3> :lua require("harpoon.ui").nav_file(3)<CR>
-- nnoremap <A-4> :lua require("harpoon.ui").nav_file(4)<CR>
-- nnoremap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
-- nnoremap <leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
-- nnoremap <leader>cu :lua require("harpoon.term").sendCommand(1, 1)<CR>
-- nnoremap <leader>ce :lua require("harpoon.term").sendCommand(1, 2)<CR>
--
-- nnoremap <leader>gc :lua require('theprimeagen.telescope').git_branches()<CR>
-- nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
-- nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
--
-- ]])

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
