-- Simple OSC52 implementation that copies yank to system clipboard
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('OSC52Yank', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.v.event.operator == 'y' then
      require('osc52').copy_register('"')
    end
  end
})

-- Set clipboard to use OSC52 when explicitly using + register
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('osc52').copy('+'),
    ['*'] = require('osc52').copy('*'),
  },
  paste = {
    ['+'] = require('osc52').paste('+'),
    ['*'] = require('osc52').paste('*'),
  },
}