-- OSC52 implementation that copies yank AND cut operations to system clipboard
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('OSC52Yank', { clear = true }),
  pattern = '*',
  callback = function()
    -- Handle both yank (y) and delete/cut operations (d, c, x)
    if vim.v.event.operator == 'y' or vim.v.event.operator == 'd' or vim.v.event.operator == 'c' then
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