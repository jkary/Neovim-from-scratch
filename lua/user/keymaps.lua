local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Detect OS
local is_mac = vim.fn.has("macunix") == 1
local is_linux = vim.fn.has("unix") == 1 and not is_mac

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- 10/29/22 - Doesn't work with Mac as it steals these...
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- OS-specific Alt key mappings
if is_mac then
  -- macOS: Alt keys generate special Unicode characters
  keymap("t", "˙", "<C-\\><C-N><C-W>h", term_opts) -- Alt+h
  keymap("t", "∆", "<C-\\><C-N><C-W>j", term_opts) -- Alt+j
  keymap("t", "˚", "<C-\\><C-N><C-W>k", term_opts) -- Alt+k
  keymap("t", "¬", "<C-\\><C-N><C-W>l", term_opts) -- Alt+l
elseif is_linux then
  -- Linux: Standard Alt key sequences work
  keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)
  keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opts)
  keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opts)
  keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", term_opts)
end

-- Try both representations for buffer switching
keymap("t", "<C-^>", "<C-\\><C-N><C-^>", term_opts)  -- Use ctrl ^ to switch bufs
keymap("t", "<C-6>", "<C-\\><C-N><C-^>", term_opts)  -- Alternative (Ctrl+6) 
-- Tab completion... maybe?  This doesn't look right...
-- keymap("i", "<Tab>", "v:lua.tab_complete", {expr = true})
-- keymap("s", "<Tab>", "v:lua.tab_complete", {expr = true})
-- keymap("i", "<S-Tab>", "v:lua.s_tab_complete", {expr = true})
-- keymap("s", "<S-Tab>", "v:lua.s_tab_complete", {expr = true})


-- -- These functions are stored in harpoon.  A plugn that I am developing
-- keymap("n", "<leader>a", "v:lua require('harpoon.mark').add_file()<CR>", opts)
-- keymap("n", "<C-a>", "v:lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
-- keymap("n", "<C-h>", "v:lua require('harpoon.ui').nav_file(1)<CR>", opts)
-- keymap("n", "<C-j>", "v:lua require('harpoon.ui').nav_file(2)<CR>", opts)
-- keymap("n", "<C-k>", "v:lua require('harpoon.ui').nav_file(3)<CR>", opts)
-- keymap("n", "<C-l>", "v:lua require('harpoon.ui').nav_file(4)<CR>", opts)
-- keymap("n", "<leader>tu", "v:lua require('harpoon.term').gotoTerminal(1)<CR>", opts)
-- keymap("n", "<leader>te", "v:lua require('harpoon.term').gotoTerminal(2)<CR>", opts)
-- keymap("n", "<leader>cu", "v:lua require('harpoon.term').sendCommand(1, 1)<CR>", opts)
-- keymap("n", "<leader>ce", "v:lua require('harpoon.term').sendCommand(1, 2)<CR>", opts)

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- Move code visually.
keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
-- Add Fugitive 3-way merge mappings
keymap("n", "<leader>2", ":diffget //2<CR>", opts)  -- take OURS (LOCAL)
keymap("n", "<leader>3", ":diffget //3<CR>", opts)  -- take THEIRS (REMOTE)
keymap("n", "]c", "]czz", opts)  -- next diff hunk, center
keymap("n", "[c", "[czz", opts)  -- prev diff hunk, center

