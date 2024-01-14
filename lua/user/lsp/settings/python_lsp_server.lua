
return {
	settings = {
      pylsp = {
        plugins = {
          -- See https://github.com/python-lsp/python-lsp-black
          black = {
            enabled=true,
            line_length=88,
          },
          mypy = {
            enabled=true,
          },
          rope = {
            enabled=true,
          },
          jedi = {
          extra_paths = { "~/samples/scaled_lab/trex/v3.04/automation/trex_control_plane/interactive"}
        }
        },
      },
	},
	before_init = function(_, config)
		config.settings.python.pythonPath = setup_venv_dir(config.root_dir)
	end,
}
