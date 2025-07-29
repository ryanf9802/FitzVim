# FitzVim

A modern, feature-rich Neovim configuration built with Lazy.nvim plugin manager.

## Features

- LSP support for Python, Lua, TypeScript/JavaScript, JSON, YAML
- Intelligent Python virtual environment detection
- Fuzzy finding with git-aware file search
- Syntax highlighting and code formatting
- Auto-completion with snippets
- File explorer and buffer management
- WSL clipboard integration

## Prerequisites

### Required
- Neovim >= 0.9.0
- Git
- `fd-find` (Ubuntu/Debian: `sudo apt install fd-find`)

### Optional
- `xclip` (for WSL clipboard integration)
- Node.js (for TypeScript/JavaScript LSP)
- Python (for Python LSP)

## Installation

1. Backup existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this configuration:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. Start Neovim - plugins will install automatically:
   ```bash
   nvim
   ```

## Installed Plugins

### Core
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [folke/snacks.nvim](https://github.com/folke/snacks.nvim) - Collection of utilities (file explorer, picker, git integration)

### LSP & Completion  
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP client configurations
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - LSP server installer
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Mason-lspconfig integration
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Auto-install formatters
- [b0o/schemastore.nvim](https://github.com/b0o/schemastore.nvim) - JSON/YAML schemas
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion engine
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - LSP completion source
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Buffer completion source
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - Path completion source
- [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) - Command line completion
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - LuaSnip completion source

### Syntax & Formatting
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Text objects
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) - Code formatting

### UI & Theme
- [catppuccin/nvim](https://github.com/catppuccin/nvim) - Color scheme
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - File icons

### Utilities
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) - Fuzzy finder backend
- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) - Commenting
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto pairs
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Auto close/rename HTML tags

## Key Bindings

### Leader Key
Leader key is set to `<Space>`

### File Operations
| Key | Action |
|-----|--------|
| `<leader>e` | Open file explorer |
| `<leader>ff` | Find files (git-aware) |
| `<leader>fg` | Live grep (git-aware) |
| `<leader>fb` | Find buffers |
| `<leader>fr` | Recent files |
| `<leader>fc` | Commands |
| `<leader>fh` | Help tags |
| `<leader>fF` | Find all files (including gitignored) |
| `<leader>fG` | Live grep all files (including gitignored) |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>r` | Rename symbol |

### Code Editing
| Key | Action |
|-----|--------|
| `<leader>f` | Format current file |
| `<leader>c` | Toggle line comment |
| `<leader>bc` | Toggle block comment |
| `gcO` | Add comment above |
| `gco` | Add comment below |
| `gcA` | Add comment at end of line |

### Completion
| Key | Action |
|-----|--------|
| `<Tab>` | Next completion item / Expand snippet |
| `<S-Tab>` | Previous completion item / Jump back in snippet |
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm completion |
| `<C-e>` | Abort completion |
| `<C-f>` | Scroll docs forward |
| `<C-b>` | Scroll docs backward |

### Treesitter Text Objects
| Key | Action |
|-----|--------|
| `af` | Select around function |
| `if` | Select inside function |
| `ac` | Select around class |
| `ic` | Select inside class |
| `aa` | Select around parameter |
| `ia` | Select inside parameter |
| `]m` | Next function start |
| `[m` | Previous function start |
| `]M` | Next function end |
| `[M` | Previous function end |
| `]]` | Next class start |
| `[[` | Previous class start |
| `][` | Next class end |
| `[]` | Previous class end |

### File Explorer (Snacks)
| Key | Action |
|-----|--------|
| `o` | Open file/folder |
| `<CR>` | Change directory |
| `t` | Open in new tab |
| `v` | Open in vertical split |

### Git
| Key | Action |
|-----|--------|
| `<leader>gb` | Git browse (open in browser) |

### Clipboard
| Key | Action |
|-----|--------|
| `<C-c>` | Copy to system clipboard (visual mode) |

## Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps.lua      # Global keymaps
│   │   └── autocommands.lua # Autocommands
│   ├── plugins/
│   │   ├── init.lua         # Plugin loader
│   │   └── *.lua           # Individual plugin configs
│   └── utils/
│       └── python.lua       # Python utility functions
├── lazy-lock.json          # Plugin version lockfile
└── CLAUDE.md              # Claude Code assistant guidance
```

## Customization

### Adding Plugins
1. Create a new file in `lua/plugins/` 
2. Return a plugin specification table
3. Restart Neovim or run `:Lazy sync`

### Modifying Settings
- Core settings: `lua/core/options.lua`
- Keymaps: `lua/core/keymaps.lua`
- Plugin configs: `lua/plugins/<plugin-name>.lua`

## Troubleshooting

### LSP Issues
- Run `:Mason` to check installed servers
- Use `:LspInfo` to debug LSP connections
- Check `:checkhealth` for system dependencies

### Python Virtual Environment
The configuration automatically detects Python virtual environments in:
- Current directory: `.venv/bin/python`
- Subdirectories with `.venv/` folders

### WSL Clipboard
Ensure `xclip` is installed: `sudo apt install xclip`
