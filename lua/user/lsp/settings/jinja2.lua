--

vim.filetype.add {
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
    j2 = 'jinja',
  },
}


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
