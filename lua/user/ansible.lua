local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	print("lspconfig plugin not found")
	return
end

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = {
--     "*ocp-labs/*/*.yml",
--     "*ansible*.yml",
--     "*.ansible.yaml",
--     "playbooks/*.yml",
--     "roles/*/tasks/*.yml",
--     "roles/*/handlers/*.yml",
--     "roles/*/defaults/*.yml",
--     "roles/*/vars/*.yml",
--     "host_vars/*",
--     "group_vars/*",
--   },
--   callback = function()
--     vim.bo.filetype = "yaml.ansible"
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*/ansible.cfg" },
--   callback = function()
--     vim.bo.filetype = "ini.ansible"
--   end,
-- }})

vim.g.ansible_goto_role_paths = './roles,../_common/roles'

-- FIXME: I think this will break when you use absolute paths. It assumes you launched from the project dir.
local function find_ansible_role_under_cursor()
  local role_paths = vim.g.ansible_goto_role_paths or "./roles"
  local cursor_word = vim.fn.expand("<cfile>") .. "/tasks/main.yml"
  local found_role_path = vim.fn.findfile(cursor_word, role_paths)

  if found_role_path == "" then
    vim.notify(cursor_word .. " not found", vim.log.levels.INFO)
  else
    vim.cmd("edit " .. vim.fn.fnameescape(found_role_path))
  end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { 
    "*/ocp-labs/*.yml",
    "*/ansible/*.yml"
  },
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,                  -- 0 means the current buffer
      "n",                -- 'n' for Normal mode
      "<leader>gr",        -- The key sequence to map
      ":call find_ansible_role_under_cursor()<CR>",    -- The command to execute. Note: if 'bar' is a Lua function,
      { noremap = true, silent = true, desc = "Run find ansible role under cursor." } -- Options
    )
    vim.api.nvim_buf_set_keymap(
      0,                  -- 0 means the current buffer
      "v",                -- 'n' for Normal mode
      "<leader>gr",        -- The key sequence to map
      ":call find_ansible_role_under_cursor()<CR>",    -- The command to execute. Note: if 'bar' is a Lua function,
      { noremap = true, silent = true, desc = "Run find ansible role under cursor." } -- Options
    )
  end,
})
