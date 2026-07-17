local util = require("lspconfig.util")

return {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/ruff", "server", "--preview" },
  filetypes = { "python" },
  root_dir = function(fname)
    -- Try to find project root
    local root = util.root_pattern(
      "pyproject.toml",
      "ruff.toml",
      ".ruff.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      ".git"
    )(fname)

    -- Fallback to the file's directory or cwd, but ensure absolute path
    root = root or util.path.dirname(fname)
    if not root or root == "" then
      root = vim.loop.cwd() -- absolute cwd fallback
    end

    return root
  end,
  settings = {},
}
