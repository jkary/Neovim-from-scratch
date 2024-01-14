function printTable(tbl, indent)
    if not indent then indent = 0 end
    if tbl == nil then return end
 
  print(tbl)
    for k, v in pairs(tbl) do
    print("here")
        local formatting = string.rep("  ", indent) -- Indentation
        formatting = formatting .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            printTable(v, indent + 1)
        else
            print(formatting .. tostring(v))
        end
    end
end

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
-- require "user.comment"
require("user.gitsigns")
require("user.nvim-tree")
-- require("user.bufferline")
-- require "user.lualine"
-- require "user.toggleterm"
-- require "user.project"
-- require "user.impatient"
-- require "user.indentline"
-- require "user.alpha"
require "user.whichkey"
require("user.autocommands")
require("user.primeagen")
require("user.markdown")
require("user.illuminate")
