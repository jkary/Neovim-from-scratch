--

vim.filetype.add {
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
    j2 = 'jinja',
  },
}

-- if you want to debug
vim.lsp.set_log_level("debug")

return {
  name = "jinja-lsp",
  cmd = { '/Users/jkary/.cargo/bin/jinja-lsp' },
  filetypes = { 'jinja', 'rust' },
  root_dir = function(fname)
    return "."
    --return nvim_lsp.util.find_git_ancestor(fname)
  end,
  init_options = {
    templates = './templates',
    backend = { './src' },
    lang = "rust"
  },
}
