local status_ok, util = pcall(require, "lspconfig/util")
if not status_ok then
  return
end
-- LSP INSTALLER 
-- The general idea here is to 
-- 1. Enable the desired server in the servers table
-- 2. Create a settings file in the lsp/settings directory which returns a table
-- 3. Create an if statement to load the settings file based on server name. 
-- 
-- The local loop with then take care of loading all the settings at once.


local servers = {
  --  "pyright",
  "pylsp",
  "ruff",
  "jinja_lsp",
  --  "solc",
  -- "lua-ls",
  "tflint",
  "ts_ls",
  "gopls",
  -- "golangci_lint_ls", -- fails to work on mac???
  "ansiblels",
  -- "yamllint"
}

local settings = {
  -- debug = true,
  ensure_installed = servers,
  -- automatic_installation = false,
  ui = {
    icons = {
      -- server_installed = "◍",
      -- server_pending = "◍",
      -- server_uninstalled = "◍",
      -- server_installed = "✓",
      -- server_pending = "➜",
      -- server_uninstalled = "✗",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },

  log_level = vim.log.levels.INFO,
  -- max_concurrent_installers = 4,
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}


local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "ls_lua" then
    local ls_lua = require "user.lsp.settings.ls_lua"
    opts = vim.tbl_deep_extend("force", ls_lua, opts)
  end

  -- if server == "pyright" then
  --   local pyright_opts = require "user.lsp.settings.pyright"
  --   opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  -- end

  -- Testing python-lsp-server

  if server == "pylsp" then
    local pylsp_opts = require "user.lsp.settings.python_lsp_server"
    opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
  end

  if server == "solang" then
    local solang_opts = require "user.lsp.settings.solang"
    opts = vim.tbl_deep_extend("force", solang_opts, opts)
  end

  if server == "solc" then
    local solc_opts = require "user.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "gopls" then
    local gopls_opts = {
      cmd = { "gopls", "serve" },
      filetypes = { "go", "gomod" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  if server == "jinja_lsp" then
    local lsp_opts = require "user.lsp.settings.jinja2"
    opts = vim.tbl_deep_extend("force", lsp_opts, opts)
  end

  if server == "ansiblels" then
    local lsp_opts = require "user.lsp.settings.ansible"
    opts = vim.tbl_deep_extend("force", lsp_opts, opts)
  end 

  if lspconfig.server ~= nil then
    lspconfig[server].setup(opts)
  end
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}
