local options = {
	backup = false,
	breakindent = true,
	cmdheight = 1,
	colorcolumn = "88",
	completeopt = { "menu", "menuone", "noselect" },
	conceallevel = 0,
	cursorline = true,
	errorbells = false,
	expandtab = true,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	incsearch = true,
	laststatus = 3,
	number = true,
	numberwidth = 4,
	pumheight = 10,
	relativenumber = true,
	scrolloff = 8,
	shiftwidth = 4,
	showmode = false,
	showtabline = 2,
	sidescrolloff = 8,
	signcolumn = "yes",
	smartcase = true,
	smartindent = true,
	softtabstop = 4,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 4,
	termguicolors = true,
	textwidth = 88,
	undofile = true,
	updatetime = 300,
	wrap = false,
	writebackup = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.iskeyword:append("-")
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")

if vim.fn.exists("&guifont") == 1 then
	vim.opt.guifont = { "Symbols Nerd Font Mono:h17", "monospace:h17" }
end

vim.opt.guicursor:append("i-ci:ver1-Cursor/Cursor-blinkwait300-blinkon200-blinkoff150")
