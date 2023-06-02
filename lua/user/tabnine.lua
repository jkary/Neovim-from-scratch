local status_ok, tabnine = pcall(require, "tabnine")
if not status_ok then
  print("Tabnine was NOT started...")
end


require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt"},
  log_file_path = "/home/jkary/.local/share/TabNine",
}) 
print("Tabnine working")
