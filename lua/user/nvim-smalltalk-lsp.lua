-- File will be called when 'require("nvim-st-lsp")'
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local h = require("null-ls.helpers")
local st_generator = h.generator_factory({
            command = "/usr/local/bin/gst",
            args = { "-q", "-g", "-f", "$FILENAME" },
            format = "line",
            from_stderr = true,
            to_temp_file = true,
            check_exit_code = function( code, stderr )
              local success = code <= 1

              if not success then 
                print(stderr)
              end
              return success
            end,
            on_output = function(line, params)
              out = h.diagnostics.from_patterns({
                {
                  pattern = [[(.*):(%d+):(.*)]],
                  groups = { "filename", "row", "message" },
                },
              })
              return out(line, params)
            end,
      })

local gst = 
  {
    name = 'smalltalk-lsp',
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "st" },
    -- name = "smalltalk-lsp",
    -- meta = {
    --   url = "https://github.com/jkary/nvim-st-lsp",
    --   description = "Simple local LSP server for GNU Smalltalk (gst).",
    -- },
    generator = st_generator,
    -- generator = debug,
  }
null_ls.register(gst)
