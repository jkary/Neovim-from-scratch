local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>ga", ":Git fetch --all<CR>", { noremap = true, silent = true })
keymap("n", "<leader>grum", ":Git rebase upstream/master<CR>", { noremap = true, silent = true })
keymap("n", "<leader>grom", ":Git rebase origin/master<CR>", { noremap = true, silent = true })

keymap("n", "<leader>gh :diffget //3<CR>", opts)
keymap("n", "<leader>gu :diffget //2<CR>", opts)
keymap("n", "<leader>gs :G<CR>", opts)
