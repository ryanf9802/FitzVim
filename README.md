# NVIM Application Directory

NeoVim (NVIM) is expected to have already been installed.

You can find instructions for NeoVim installation
[here](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)
(Chocolatey package installation is recommended).

## Table of Contents

1. [Cloning / Usage](#cloning--usage)
   - [Windows 11 (PowerShell)](#windows-11-powershell)
2. [Getting Started](#getting-started)
3. [Requirements](#requirements)

## Cloning / Usage

Ensure all dependencies are installed as described in
[Requirements](#requirements).

### Windows 11 (PowerShell)

Ensure `$HOME\AppData\Local\nvim` does not exist.
This command can be used to delete it if it does:

```powershell
Remove-Item -Recurse -Force $HOME\AppData\Local\nvim
```

Run the following command in PowerShell:

```powershell
git clone https://github.com/ryanf9802/NeoVim-Configuration.git $HOME\AppData\Local\nvim ;
. $HOME\AppData\Local\nvim\create_ps_profile_var.ps1 ;
cd $nvim
;
```

If you would like to avoid manually installing the requirements,
run the following command:

```powershell
. $nvim\install_requirements.ps1
```

## Getting Started

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

### NeoCodeium (AI Autocompletion)

NeoCodeium provides optional AI-powered code suggestions.

#### Using It:

- While in insert mode, suggestions appear inline as you type.
- Press `<Alt-f>` to accept the full suggestion.

#### First-Time Setup:

- On first use, NeoCodeium will prompt you to authenticate in the browser.
- Follow the on-screen instructions to link your editor with Codeium.

#### Note:

NeoCodeium is **completely optional**. If you choose not to authenticate:

- It will not provide any AI suggestions.
- It will not read or send any code.
- Your editor experience will remain exactly the same, with no impact on
  performance or features.

You can safely ignore the prompt if you do not wish to use it.

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

## Requirements

These requirements can be manually installed using the following commands, but
**are included in the installation process in [Cloning /
Usage](#cloning--usage)**.

### Chocolately

> For managing/installing CLI tools/packages

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Be sure to run `choco --version` afterwards to validate installation.

### Node.JS and NPM

```
choco install nodejs.install -y
```

### Ripgrep

> For telescope fuzzy finder live grep

```
choco install ripgrep -y
```

Run `rg --version` to validate installation.

### Make

> For improved fuzzy find matching

```
choco install make -y
```

Run `make --version` to validate installation.
