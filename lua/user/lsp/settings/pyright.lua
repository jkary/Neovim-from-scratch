local configs = require("lspconfig/configs")
local util = require("lspconfig/util")
local path = util.path

local function setup_venv_dir(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return path.join(path.dirname(match), "bin", "python")
		end
	end

	-- FIXME: Fallback to system Python.
	return exepath("python3") or exepath("python") or "python"
end

return {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
	before_init = function(_, config)
		config.settings.python.pythonPath = setup_venv_dir(config.root_dir)
	end,
}
