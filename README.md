# NVIM Application Directory

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

```rm
-Recurse -Force $HOME\AppData\Local\nvim`
```

Run the following command in PowerShell:

```powershell
git clone https://github.com/ryanf9802/nvim.git $HOME\AppData\Local\nvim ;
. $HOME\AppData\Local\nvim\add_to_path.ps1 ;
cd $nvim
;
```

## Requirements

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
