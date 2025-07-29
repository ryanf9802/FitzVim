# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration built around the Lazy.nvim plugin manager. The configuration follows a modular structure:

- `init.lua`: Entry point that loads core modules and plugin setup
- `lua/core/`: Core Neovim configuration (options, keymaps, autocommands)
- `lua/plugins/`: Individual plugin configurations as separate modules
- `lua/utils/`: Utility functions (currently Python virtual environment detection)
- `lazy-lock.json`: Plugin version lockfile managed by Lazy.nvim

### Plugin Architecture

The `lua/plugins/init.lua` file dynamically loads all plugin configuration files from the plugins directory. Each plugin is configured in its own file and returns a table that gets merged into the main plugin list.

### Key Components

- **LSP Setup**: Configured for Python (Pyright), Lua (lua_ls), TypeScript/JavaScript (ts_ls), JSON (jsonls), and YAML (yamlls)
- **Mason Integration**: Automatic installation of LSP servers and formatters
- **Python Virtual Environment Detection**: Custom utility in `utils/python.lua` that finds and uses project-specific Python virtual environments
- **Formatting**: Conform.nvim with Black (Python), Stylua (Lua), and Prettier (JS/TS/JSON/YAML)
- **Clipboard Integration**: WSL-optimized clipboard setup using xclip

## Development Commands

This is a Neovim configuration, not a traditional software project. Configuration changes are applied by:

1. Editing configuration files
2. Restarting Neovim or using `:source %` for the current file
3. Running `:Lazy sync` to update plugins when needed

### Plugin Management

- `:Lazy` - Open Lazy.nvim plugin manager UI
- `:Lazy sync` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Mason` - Open Mason UI for LSP/formatter management

### Formatting

- `<leader>f` - Format current file (where leader is space)

## Prerequisites

Based on README.md, the configuration requires:
- `fd-find` package (Ubuntu/Linux): `sudo apt update && sudo apt install fd-find`
- For WSL users: `xclip` for clipboard integration

## Key Configuration Details

- Leader key is set to space
- Uses relative line numbers and 2-space indentation
- Mouse support is disabled
- Global statusline enabled (`laststatus = 3`)
- Text width set to 120 characters
- WSL clipboard integration via xclip when available
- Automatic image file handling: opens images in system viewer and closes buffer

## Python Development

The configuration includes intelligent Python virtual environment detection that:
- Checks for `.venv/bin/python` in current directory
- Scans subdirectories for virtual environments
- Caches the found Python path for performance
- Configures Pyright LSP to use the detected Python interpreter