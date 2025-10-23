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
print("HERE")
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
  ensure_installed = { "lua_ls", "pylsp" },
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
    print("Setting up pylsp")
    local pylsp_opts = require("user.lsp.settings.python_lsp_server")
    local config = vim.tbl_deep_extend("force", pylsp_opts, base_config)
    vim.lsp.config[server_name] = config
    print("pylsp config set")
  end
  
  vim.lsp.enable(server_name)
  if server_name == "pylsp" then
    print("pylsp enabled")
  end
end

-- Setup servers
setup_server("lua_ls")
setup_server("pylsp")
