#!/bin/bash

if [ -d ~/.config/nvim ]; then
  echo 'Moving init.lua to old_init_lua...'
  mv ~/.config/nvim/init.lua ~/.config/nvim/old_init_lua
  ln -s ~/src/lua/Neovim-from-scratch/init.lua ~/.config/nvim/init.lua
fi

echo Installing plugins in headless mode.
nvim --headless -c 'PackerUpdate' -c 'qall'
