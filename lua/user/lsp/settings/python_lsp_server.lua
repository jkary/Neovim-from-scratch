local function setup_venv_dir(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(vim.fs.joinpath(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return vim.fs.joinpath(vim.fs.dirname(match), "bin", "python")
    end
  end

  -- FIXME: Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
  settings = {
    pylsp = {
      plugins = {
        -- See https://github.com/python-lsp/python-lsp-black
        black = {
          enabled = true,
          line_length = 88,
        },
        mypy = {
          enabled = true,
        },
        rope = {
          enabled = true,
        },
        jedi = {
          extra_paths = { "~/samples/scaled_lab/trex/v3.04/automation/trex_control_plane/interactive" }
        }
      },
    },
    python = {
      pythonPath = setup_venv_dir(vim.fn.getcwd())
    },
  }
}
