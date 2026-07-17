local osc52_ok, osc52 = pcall(require, "osc52")
if not osc52_ok then
	return
end

if #vim.api.nvim_list_uis() == 0 then
	return
end

osc52.setup({
	silent = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("OSC52Yank", { clear = true }),
	callback = function()
		if vim.v.event.operator == "y" and (vim.v.event.regname == "+" or vim.v.event.regname == "*") then
			osc52.copy_register(vim.v.event.regname)
		end
	end,
})

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = osc52.copy("+"),
		["*"] = osc52.copy("*"),
	},
	paste = {
		["+"] = osc52.paste("+"),
		["*"] = osc52.paste("*"),
	},
}
