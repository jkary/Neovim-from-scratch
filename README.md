# Neovim configuration

Personal Neovim configuration, originally forked from LunarVim's
`Neovim-from-scratch`, now maintained as a standalone config.

## Requirements

- Neovim 0.12 or newer
- Git, `rg`, `make`, and a C compiler for native plugin builds
- Node.js/npm for `markdown-preview.nvim`
- A Nerd Font, preferably `Symbols Nerd Font Mono`, for completion and UI icons
- Optional language tools managed through Mason: `lua_ls`, `pylsp`, `ruff`, `gopls`,
  `golangci_lint_ls`, `jsonls`, and `ansiblels`

## Layout

- `init.lua` sets leaders and loads the core user modules.
- `lua/user/plugins.lua` bootstraps `lazy.nvim` and imports plugin specs from
  `lua/plugins/`.
- `lua/plugins/` contains focused Lazy specs for UI, completion, LSP, Git,
  formatting, testing, Markdown, editor tools, and AI helpers.
- `lua/user/` contains the actual configuration modules consumed by those specs.
- `lua/user/lsp/settings/` contains per-server LSP settings.

## Install

Clone this repository as your Neovim config:

```bash
git clone https://github.com/jkary/Neovim-from-scratch.git ~/.config/nvim
nvim
```

Or run the install helper from a checked-out copy:

```bash
./install.bash
```

On first launch, Lazy will install plugins automatically. To force a sync:

```vim
:Lazy sync
```

## Health

Run:

```vim
:checkhealth
```

A few external tools are intentionally optional. Mason installs language servers,
while formatters such as `prettier`, `prettierd`, `gofumpt`, `goimports`, and
`yamlfmt` are used by Conform when available.
