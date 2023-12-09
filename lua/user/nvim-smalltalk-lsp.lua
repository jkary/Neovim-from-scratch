-- File will be called when 'require("nvim-st-lsp")'
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local h                   = require("null-ls.helpers")

local st_generator        = h.generator_factory({
  command = "/usr/local/bin/gst",
  args = { "-q", "-g", "-f", "$FILENAME" },
  format = "line",
  from_stderr = true,
  to_temp_file = true,
  check_exit_code = function(code, stderr)
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

local smalltalk_formatter = function(opts, done)
  P(opts)
  local code = opts.content
  -- Define indentation and other formatting settings
  local indentSpaces = 4

  -- Initialize variables
  local currentIndent = 0
  local formattedCode = ""

  -- Helper function to add the specified number of spaces to the formatted code
  local function addIndentation()
    for _ = 1, currentIndent do
      formattedCode = formattedCode .. string.rep(" ", indentSpaces)
    end
  end

  -- Process each line of code
  for _, line in ipairs(code) do
    -- Trim leading and trailing whitespaces
    line = line:match("^%s*(.-)%s*$")
    print("line match" .. line)
    if line ~= "" then
      -- Check if the line starts a block or ends a block
      local startsBlock = line:find("%b{}") ~= nil
      local endsBlock = line:find("^%s*%}") ~= nil

      if endsBlock then
        -- Decrease the indentation level
        currentIndent = currentIndent - 1
      end

      -- Add indentation to the formatted code
      addIndentation()

      -- Add the line to the formatted code
      formattedCode = formattedCode .. line

      if not startsBlock and not endsBlock then
        -- Add a line break if the line doesn't start or end a block
        formattedCode = formattedCode .. "\n"
      end

      if startsBlock then
        -- Increase the indentation level
        currentIndent = currentIndent + 1
      end
    end
  end
  return done({ { source = formattedCode } })
end

local stf                 = {
  async = true,
  name = "smalltalk_formatter",
  filetypes = { "st" },
  method = null_ls.methods.FORMATTING,
  generator = {
    fn = smalltalk_formatter,
  },
}

local gst                 =
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
null_ls.register(stf)
