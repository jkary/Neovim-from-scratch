return {
	{
		"rafi/awesome-vim-colorschemes",
		lazy = false,
		priority = 1000,
		config = function()
			require("user.colorscheme")
		end,
	},
}
