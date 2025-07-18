local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()


-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My jkary plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("https://github.com/nvim-tree/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	-- use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")

	-- Colorschemes
	use("lunarvim/colorschemes") -- A bunch of colorschemes you can try out
	use("lunarvim/darkplus.nvim")
	use("rafi/awesome-vim-colorschemes")
	use("morhetz/gruvbox")
	use("Murtaza-Udaipurwala/gruvqueen")
	-- use 'altercation/vim-colors-solarized'

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use({ "codota/tabnine-nvim", run = "./dl_binaries.sh" })
	use("windwp/nvim-autopairs") -- Not sure if I still need this anymore JK
	use("hrsh7th/cmp-emoji")
	use("rcarriga/cmp-dap")
	use({
		"tzachar/cmp-tabnine",
		config = function()
			local tabnine = require("cmp_tabnine.config")
			tabnine:setup({
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
				ignored_file_types = { -- default is not to ignore
					-- uncomment to ignore in lua:
					-- lua = true
				},
			})
		end,
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
	})

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("tomv564/pyls-mypy")
	-- use("microsoft/pyright")
	use("juliosueiras/terraform-lsp")
	use("pedro757/emmet")
	use("RRethy/vim-illuminate")
	use("b0o/SchemaStore.nvim")
	use("ambv/black")
	use("rupert/pyls-black")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-project.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")

	-- Debug Plugin
	use("mfussenegger/nvim-dap")
	-- use("actboy168/lua-debug")

	-- The Primeagen
	use("ThePrimeagen/git-worktree.nvim")
	use("ThePrimeagen/harpoon")
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- Python plugins
	use({
		"amirali/yapf.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("yapf").setup({})
		end,
	})

	use({ "iamcco/markdown-preview.nvim" })
	use("junegunn/fzf")
	use("junegunn/fzf.vim")
	use("sbdchd/neoformat")

	-- Playing with quickfix
	use("kevinhwang91/nvim-bqf")
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins

	use("pearofducks/ansible-vim")

	-- Setup of avante
	use("MunifTanjim/nui.nvim")
	use("MeanderingProgrammer/render-markdown.nvim")
	use("HakonHarnes/img-clip.nvim")
	use("zbirenbaum/copilot.lua")
	use("stevearc/dressing.nvim")
	use("folke/snacks.nvim")

	use({
		"yetone/avante.nvim",
		branch = "main",
		run = "make",
		config = function()
			require("user.avante").setup()
		end,
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
