local status_ok, mason = pcall(require, "mason")
if not status_ok then
  print("Mason is not loaded.")
  return
end

local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not status_ok then
  print("Mason-lspconfig is not loaded.")
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

mason_lsp.setup({
  ensure_installed = { "lua_ls", "pylsp", "ruff", "gopls", "golangci_lint_ls" },
  automatic_installation = true,
})

-- Use new v0.11 LSP config system
local function setup_server(server_name)
  local base_config = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server_name == "lua_ls" then
    local luals_opts = require("user.lsp.settings.luals")
    local config = vim.tbl_deep_extend("force", luals_opts, base_config)
    vim.lsp.config[server_name] = config
  elseif server_name == "pylsp" then
    local pylsp_opts = require("user.lsp.settings.python_lsp_server")
    local config = vim.tbl_deep_extend("force", pylsp_opts, base_config)
    vim.lsp.config[server_name] = config
  elseif server_name == "ruff" then
    local ruff_opts = require("user.lsp.settings.ruff")
    -- force a root_dir and attach now, rather than lazy enabling
    vim.lsp.start({
      name = "ruff",
      cmd = ruff_opts.cmd,
      root_dir = ruff_opts.root_dir(vim.api.nvim_buf_get_name(0)),
      filetypes = ruff_opts.filetypes,
      on_attach = ruff_opts.on_attach,
      capabilities = ruff_opts.capabilities,
      settings = ruff_opts.settings,
    })
    return
  elseif server_name == "gopls" then
    local gopls_opts = require("user.lsp.settings.golang")
    local config = vim.tbl_deep_extend("force", gopls_opts, base_config)
    vim.lsp.config[server_name] = config
  elseif server_name == "golangci_lint_ls" then
    vim.lsp.config[server_name] = base_config
  end

  vim.lsp.enable(server_name)
end

-- Setup servers
setup_server("lua_ls")
setup_server("pylsp")
setup_server("ruff")
setup_server("gopls")
setup_server("golangci_lint_ls")
