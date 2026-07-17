local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local icons = require("user.icons")

local function hide_in_width()
	return vim.fn.winwidth(0) > 80
end

local function progress()
	local current_line = vim.fn.line(".")
	local total_lines = math.max(vim.fn.line("$"), 1)
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local index = math.ceil((current_line / total_lines) * #chars)
	return chars[index]
end

local function spaces()
	return "spaces: " .. vim.bo.shiftwidth
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "toggleterm" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			{
				"branch",
				icon = icons.git.Branch,
			},
		},
		lualine_b = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = {
					error = icons.diagnostics.Error,
					warn = icons.diagnostics.Warning,
				},
				colored = false,
				update_in_insert = false,
				always_visible = true,
			},
		},
		lualine_c = {
			{
				"filename",
				path = 2,
			},
		},
		lualine_x = {
			{
				"diff",
				colored = false,
				symbols = {
					added = icons.git.Add,
					modified = icons.git.Mod,
					removed = icons.git.Remove,
				},
				cond = hide_in_width,
			},
			spaces,
			"encoding",
			{
				"filetype",
				icons_enabled = false,
			},
		},
		lualine_y = {
			{
				"location",
				padding = 0,
			},
		},
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree", "quickfix" },
})
