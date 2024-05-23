require("lspconfig").ruff_lsp.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
  end,
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    },
  },
})
