# Personal NeoVim Configuration

NeoVim (NVIM) is expected to have already been installed.

You can find instructions for NeoVim installation
[here](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)
(Chocolatey package installation is recommended).

## Table of Contents

1. [Installation](#installation)
   - [Ubuntu/Linux](#ubuntulinux)
2. [Getting Started](#getting-started)
   - [File Navigation](#file-navigation)
   - [Finding Files and Searching](#finding-files-and-searching)
   - [Formatting Code](#formatting-code)
   - [SuperMaven (AI Autocompletion)](#supermaven-ai-autocompletion)
   - [Completion and LSP Features](#completion-and-lsp-features)
   - [Tips and Advanced Usage](#tips-and-advanced-usage)
3. [Adding New Plugins](#adding-new-plugins)
4. [Requirements](#requirements)

## Installation

### Ubuntu/Linux

First, ensure all dependencies are installed as described in [Requirements](#requirements).

Backup any existing Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

Clone this configuration:
```bash
git clone https://github.com/ryanf9802/NeoVim-Configuration.git ~/.config/nvim
```

Or using GitHub CLI:
```bash
gh repo clone https://github.com/ryanf9802/NeoVim-Configuration.git ~/.config/nvim
```

## Getting Started

This section provides a step-by-step guide to getting started with this
configuration. It does not include basic NeoVim usage, but it is intended to
get you up and running with this specific configuration.

Once you're inside a project directory, launch Neovim by running:

```bash
nvim
```

You're now using the custom environment defined in this configuration. Here are
some common workflows and keybindings to get started quickly.

---

### File Navigation

- Press `<Space>e` to toggle the file explorer (`nvim-tree`), which appears on
  the **right** side.
- Inside the tree:
  - Press `v` to open files in a vertical split
  - Press `s` to open in a horizontal split
  - Press `t` to open in a new tab

> Note: `<Space>` is the leader key, commonly referenced in Neovim
> documentation as `<leader>`.

---

### Finding Files and Searching

This configuration uses Telescope for fuzzy finding and search:

- `<Space>ff` — Find files
- `<Space>fs` — Find Git-tracked files
- `<Space>fg` — Live grep (uses Git file scope if available)
- `<Space>/` — Search within the current buffer
- `<Space>fb` — Open file browser (Telescope interface)

---

### Formatting Code

- Press `<Space>f` to format the current file.
  - Automatically uses the appropriate formatter depending on filetype:
    - Python → `black`
    - JavaScript/TypeScript → `prettier`
    - Lua → `stylua`
    - HTML/CSS/JSON/Markdown → `prettier`

Formatting runs asynchronously and will fall back to LSP formatting if needed.

---

### SuperMaven (AI Autocompletion)

SuperMaven provides optional AI-powered code suggestions.

#### Using It:

- While in insert mode, suggestions appear inline as you type.
- Press `<Tab>` to accept the full suggestion.
- Press `<C-j>` to accept the current word.
- Press `<C-]>` to clear the suggestion.

#### First-Time Setup:

- On first use, SuperMaven will prompt you to enable SuperMaven for your editor.
- You can run :SupermavenUseFree to use the free tier.

#### Note:

SuperMaven is **completely optional**. If you choose not to enable it:

- It will not provide any AI suggestions.
- It will not read or send any code.
- Your editor experience will remain exactly the same, with no impact on performance or features.

You can safely ignore the prompt if you do not wish to use it.

#### Removing SuperMaven

SuperMaven is optional and can be removed at any time with no impact on the rest of the setup.

##### Steps to Remove:

1. **Delete the Plugin File**  
   Remove the `supermaven.lua` plugin definition:

```bash
rm ~/.config/nvim/lua/plugins/supermaven.lua
```

2. **Remove the Plugin Entry**  
   Edit `~/.config/nvim/lua/plugins/init.lua` and delete the line that loads SuperMaven:

```lua
-- Remove this line:
require("plugins.supermaven"),
```
SuperMaven will no longer be loaded or available in your setup. You do not need to uninstall anything else.

---

### Completion and LSP Features

- Autocompletion is enabled by default using `nvim-cmp` with LSP and snippet
  sources.
- `<C-Space>` — Manually trigger completion in insert mode
- `<Enter>` — Confirm selected completion

Language servers are automatically set up for Python, JavaScript/TypeScript,
and Lua, with inline diagnostics, formatting, and hover docs.

---

### Tips and Advanced Usage

- **Project Files (`<Space>p`)**: A smart fallback command. Tries to load
  Git-tracked files, but defaults to normal file search if not in a repo.
- **Copy to System Clipboard**: Visual select and press `<C-c>` to copy to
  system clipboard.
- **Python Virtual Envs**: `.venv` folders at the root or one level deep will
  be automatically detected for LSP and formatting.
- **Themes**: Uses the `catppuccin` theme with transparent background enabled
  by default.
- **Plugin Management**: All plugins are managed via `lazy.nvim`, configured in
  `lua/plugins/`. You can add or remove plugins by editing files in that
  directory.
- **Split Windows Quickly**: Use the `nvim-tree` mappings (`v`, `s`, `t`) or
  standard Neovim commands (`:vsp`, `:sp`, `:tabnew`) for flexible layout
  control.

---

This setup is built for speed and convenience, and aims to be minimal but
powerful out of the box.

## Adding New Plugins

All plugins are managed via [`lazy.nvim`](https://github.com/folke/lazy.nvim),
and plugin definitions live inside the `lua/plugins/` directory. To add a new
plugin:

### 1. Create a Plugin File

Create a new file inside the `lua/plugins/` directory. The filename can
describe the plugin's purpose, e.g., `comment.lua`.

Example for [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim):

```lua
-- lua/plugins/comment.lua
return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
  end,
}
```

### 2. Register the Plugin

Ensure the new plugin file is included in `lua/plugins/init.lua`. Add it to the
returned list:

```lua
return {
  -- other plugins...
  require("plugins.comment"),
}
```

### Installing Formatters with Mason

This setup uses [`conform.nvim`](https://github.com/stevearc/conform.nvim) for formatting and [`mason.nvim`](https://github.com/williamboman/mason.nvim) for managing formatter binaries.

#### Installing a Code Formatter

To install a formatter, use the `:Mason` command to open the Mason UI:

```vim
:Mason
```

Press `5` to filter by only formatters.

Search for the formatter you need and press `i` to install it.

For example, to install:

- `black` for Python
- `prettier` for JavaScript, TypeScript, HTML, CSS, JSON, Markdown
- `stylua` for Lua

Once installed, `conform.nvim` will automatically pick it up and use it when formatting the appropriate file types.

#### Verifying Installation

You can verify that a formatter is installed and working by running:

```vim
:Mason
```

And checking that the formatter appears under "Installed".

#### Optional: Install via CLI

Alternatively, install formatters via command-line:

```bash
# Python
pip install black

# JavaScript/TypeScript/etc.
npm install -g prettier

# Lua
cargo install stylua
```

> **Note**: Using `:Mason` is the recommended approach, as it installs in an isolated environment managed by Neovim.

## Requirements

Install the following dependencies on Ubuntu/Linux:

### Essential Packages

```bash
# Update package index
sudo apt update

# Install Neovim (if not already installed)
sudo apt install neovim

# Install required dependencies
sudo apt install nodejs npm ripgrep build-essential git curl

# For WSL clipboard integration (if using WSL)
sudo apt install xclip
```

### Verify Installation

```bash
# Verify installations
nvim --version
node --version
npm --version
rg --version
make --version
```

### Optional: Install formatters system-wide

```bash
# Python formatter
pip install black

# JavaScript/TypeScript formatter
npm install -g prettier

# Lua formatter (requires Rust)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
cargo install stylua
```

> **Note**: Formatters can also be installed through Mason (`:Mason` command) once Neovim is running.
