# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration based on the "Neovim from scratch" approach using Packer.nvim as the plugin manager. The configuration is organized in a modular structure under `lua/user/`:

### Core Structure
- `init.lua` - Main entry point that requires all modules
- `lua/user/plugins.lua` - Plugin definitions and setup using Packer
- `lua/user/options.lua` - Neovim options and settings
- `lua/user/keymaps.lua` - Key mappings with OS-specific handling
- `lua/user/lsp/` - LSP configuration with language-specific settings
- `lua/user/colorscheme.lua` - Theme configuration

### Key Components
- **Plugin Manager**: Packer.nvim with auto-installation
- **LSP**: Custom LSP setup without Mason, uses individual language servers
- **Completion**: nvim-cmp with multiple sources including TabNine AI
- **File Management**: nvim-tree for file explorer
- **Fuzzy Finding**: Telescope for file/text search
- **Git Integration**: Fugitive + Gitsigns
- **Syntax**: Treesitter for highlighting and parsing
- **AI Integration**: Claude Code plugin and TabNine for completions

### LSP Configuration
LSP settings are organized by language in `lua/user/lsp/settings/`:
- Python: pyright, python_lsp_server, ruff_lsp support
- Go: golang.lua settings
- Terraform: terraform_lsp.lua
- Lua: luals.lua for Neovim development
- Ansible: ansible.lua for playbook editing
- JSON: jsonls.lua with SchemaStore integration

## Common Development Tasks

### Plugin Management
```bash
# Install/update plugins (from within Neovim)
:PackerSync

# Clean unused plugins
:PackerClean

# Plugin installation is automatic on first run
nvim --headless -c 'PackerUpdate' -c 'qall'
```

### Health Check
```bash
# Check Neovim health and dependencies
:checkhealth
```

### Requirements
- Neovim v0.6.0 or later
- Python support: `pip install pynvim`
- Node.js support: `npm i -g neovim` (optional)
- System clipboard: `xsel` (Linux) or `pbcopy` (macOS)

## Configuration Patterns

### Module Loading
All modules are loaded via `require()` calls in `init.lua`. Disabled modules are commented out rather than removed.

### Options Setting
Options are defined in a table in `options.lua` and applied via a loop using `vim.opt[k] = v`.

### Key Mappings
- Cross-platform key handling for macOS and Linux differences
- OS detection using `vim.fn.has()` 
- Terminal mode mappings handle Alt key variations between platforms
- Fugitive merge conflict resolution mappings (`<leader>2`, `<leader>3`)

### LSP Setup
- Language servers configured individually without Mason
- Settings stored in separate files per language
- Protected calls (`pcall`) used for error handling
- Custom handlers and formatting setup available but commented out

### Plugin Configuration
- Plugins configured inline within the Packer specification
- Complex plugins have dedicated configuration files in `lua/user/`
- Auto-installation and bootstrapping handled automatically

## Special Features

### Clipboard Integration
OSC52 clipboard integration for terminal/SSH usage configured in `init.lua` and `osc52.lua`.

### AI Integration
- TabNine AI completion configured with custom settings
- Claude Code plugin for AI assistance
- Multiple completion sources in nvim-cmp

### Git Workflow
- Fugitive for Git operations with custom merge conflict mappings
- Gitsigns for inline Git status
- Git worktree support via ThePrimeagen's plugin

### Development Tools
- Ansible syntax support and LSP
- Terraform LSP integration
- Python formatting with yapf and black
- Markdown preview capabilities
- require('lsp-config') framework is deprecated