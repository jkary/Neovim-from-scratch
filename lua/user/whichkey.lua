local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

which_key.setup({})

if which_key.add then
	which_key.add({
		{ "<leader>d", group = "Debug" },
		{ "<leader>f", group = "Find" },
		{ "<leader>g", group = "Git" },
		{ "<leader>l", group = "LSP" },
		{ "<leader>o", group = "Options" },
		{ "<leader>p", group = "Plugins" },
		{ "<leader>s", group = "Search" },
		{ "<leader>t", group = "Terminal" },
	})
else
	which_key.register({
		d = { name = "Debug" },
		f = { name = "Find" },
		g = { name = "Git" },
		l = { name = "LSP" },
		o = { name = "Options" },
		p = { name = "Plugins" },
		s = { name = "Search" },
		t = { name = "Terminal" },
	}, { prefix = "<leader>" })
end
