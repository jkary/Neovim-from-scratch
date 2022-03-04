local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
  print("Harpoon did not load.")
  return
end
vim.cmd [[ 
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <C-P> :lua require('telescope').extensions.project.project{}<CR>
nnoremap <A-1> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <A-2> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <A-3> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <A-4> :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>cu :lua require("harpoon.term").sendCommand(1, 1)<CR>
nnoremap <leader>ce :lua require("harpoon.term").sendCommand(1, 2)<CR>

nnoremap <leader>gc :lua require('theprimeagen.telescope').git_branches()<CR>
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

]]
