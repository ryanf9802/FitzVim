# NVIM Application Directory

NeoVim (NVIM) is expected to have already been installed.

You can find instructions for NeoVim installation
[here](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package)
(Chocolatey package installation is recommended).

## Table of Contents

1. [Cloning / Usage](#cloning--usage)
   - [Windows 11 (PowerShell)](#windows-11-powershell)
2. [Requirements](#requirements)

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
