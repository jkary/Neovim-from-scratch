local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("nvim-tree.lua is not loaded", vim.log.levels.WARN)
	return
end

local icons = require("user.icons")

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return {
			buffer = bufnr,
			desc = "nvim-tree: " .. desc,
			noremap = true,
			nowait = true,
			silent = true,
		}
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
end

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = false,
	update_cwd = false,
	diagnostics = {
		enable = true,
		icons = {
			hint = icons.diagnostics.Hint,
			info = icons.diagnostics.Information,
			warning = icons.diagnostics.Warning,
			error = icons.diagnostics.Error,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	filters = {
		dotfiles = true,
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	on_attach = on_attach,
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})
