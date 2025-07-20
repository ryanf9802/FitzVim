# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Neovim configuration built on the `lazy.nvim` plugin manager. The configuration is structured as follows:

- `init.lua` - Entry point that loads core modules and lazy.nvim setup
- `lua/core/` - Core Neovim configuration (options, keymaps, autocommands, commands)
- `lua/plugins/` - Individual plugin configurations, all loaded via `plugins/init.lua`
- `lua/utils/` - Utility modules (currently Python virtual environment detection)
- `lua/snippets/` - Language-specific snippets

## Key Configuration Details

### Plugin Management
- Uses `lazy.nvim` for plugin management
- All plugins are defined in separate files under `lua/plugins/`
- Plugin loading is centralized in `lua/plugins/init.lua`

### Leader Key and Important Keybindings
- Leader key is `<Space>`
- `<leader>f` - Format current file/selection using conform.nvim (special log file handling)
- `<leader>e` - Toggle nvim-tree file explorer (displays on right side)
- `<leader>ff` - Find all files (excludes node_modules, __pycache__, .venv, .git)
- `<leader>p` - Smart project files (git files if in repo, otherwise all files)  
- `<leader>fg` - Live grep with git file scope if available
- `<leader>fb` - Open Telescope file browser
- `<leader>/` - Search within current buffer
- `<leader>r` - LSP incremental rename using inc-rename.nvim
- `<leader>o` - Toggle outline view
- `<C-c>` in visual mode - Copy to system clipboard

### Formatting Configuration
Located in `lua/plugins/conform.lua`:
- Python: `black`
- JavaScript/TypeScript: `prettier`
- HTML/CSS/JSON/JSONL/Markdown: `prettier`
- Lua: `stylua`
- SQL: `sqruff`
- Terraform: `terraform_fmt`

### Python Environment Detection
The configuration automatically detects Python virtual environments:
- Searches for `.venv` at project root or one level deep
- Sets `vim.g.python3_host_prog` automatically for LSP integration

### Clipboard Integration
Special handling for WSL environments:
- Uses `xclip` for clipboard integration when in WSL
- Automatically configures clipboard registers for seamless copy/paste

## Common Development Tasks

### Adding New Plugins
1. Create new plugin file in `lua/plugins/` (e.g., `lua/plugins/newplugin.lua`)
2. Add plugin spec following lazy.nvim format
3. Add `require("plugins.newplugin")` to `lua/plugins/init.lua`

### Formatting Setup
- Formatters are managed via Mason (`:Mason` command)
- Install formatters through Mason UI or via system package managers
- Configuration is handled automatically by conform.nvim based on filetype

### Testing Changes
- Configuration changes take effect on restart: `:q` then relaunch `nvim`
- For plugin changes, use `:Lazy` to manage plugin installation/updates

### Requirements Installation
Required dependencies for Ubuntu/Linux:
- Node.js and npm (for LSP servers and prettier)
- ripgrep (`rg`) for Telescope file search  
- build-essential (includes make for improved fuzzy finding)
- xclip (for WSL clipboard integration)

Install with: `sudo apt install nodejs npm ripgrep build-essential xclip`

## File Structure Patterns
- Keep plugin configurations isolated in separate files
- Use descriptive filenames matching plugin functionality
- Follow existing patterns for keybinding descriptions and plugin setup
- Maintain the modular structure with clear separation between core config and plugins