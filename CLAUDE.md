# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Architecture Overview

This is a standalone personal Neovim configuration. It uses `lazy.nvim` for
plugin management and Neovim's native 0.11+ LSP configuration APIs.

### Core Structure

- `init.lua` - Main entry point; sets leaders and loads core modules.
- `lua/user/plugins.lua` - Bootstraps Lazy and imports `lua/plugins/`.
- `lua/plugins/` - Focused Lazy specs by area: UI, completion, LSP, Git,
  formatting, testing, Markdown, editor tools, and AI helpers.
- `lua/user/options.lua` - Editor options.
- `lua/user/keymaps.lua` - Key mappings, including macOS terminal mappings.
- `lua/user/lsp/` - LSP setup, handlers, and per-server settings.
- `lua/user/icons.lua` - Shared Nerd Font / Codicon glyph table.

### Key Components

- Plugin manager: `lazy.nvim`
- LSP: `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`, and native
  `vim.lsp.config`
- Completion: `nvim-cmp` with LuaSnip, LSP, buffer, path, emoji, cmdline, and
  DAP sources
- Formatting: `conform.nvim`
- File management: `nvim-tree.lua` and `oil.nvim`
- Fuzzy finding: Snacks picker
- Git integration: Fugitive, Gitsigns, Diffview, and Neogit
- Syntax/navigation: Treesitter, Treesitter context, Flash, Trouble, BQF
- AI helpers: Claude Code and Avante

## Common Development Tasks

### Plugin Management

```vim
:Lazy sync
:Lazy update
:Lazy clean
```

Headless sync for validation:

```bash
nvim --headless "+Lazy! sync" +qa
```

### Health Check

```vim
:checkhealth
```

### Startup Check

```bash
nvim --headless +qa
```

## Configuration Patterns

- Keep plugin specifications in `lua/plugins/`; keep plugin behavior in
  `lua/user/` modules.
- Prefer Neovim's native APIs over legacy `lspconfig.setup`, old diagnostic
  helpers, or pre-Lazy plugin commands.
- Use Mason's current `automatic_enable` behavior. The old
  `automatic_installation` setting is no longer supported.
- Use Conform as the formatting entry point. Avoid reintroducing Neoformat,
  YAPF-only, or Black-only formatting paths unless there is a specific reason.
- Keep icons centralized in `lua/user/icons.lua` so completion, diagnostics, and
  statusline glyphs stay consistent.

## Notes

- This config assumes a modern Nerd Font. Missing or boxed icons usually mean the
  terminal font needs to be changed.
- OSC52 clipboard support is only initialized when Neovim has a UI attached, so
  headless validation remains quiet.
- Stale modules may still exist under `lua/user/` for reference, but only modules
  referenced by `init.lua` or `lua/plugins/` are active.
