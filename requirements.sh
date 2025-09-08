#!/bin/bash

sudo apt update

# Python tooling for Mason-managed formatters/linters (e.g., black)
# Mason creates a virtualenv and installs packages with pip; these are required.
sudo apt install -y python3 python3-venv python3-pip

# Fast file finder used by file tree search (fd/fdfind)
sudo apt install -y fd-find

# Ensure `fd` is available as a command (Debian/Ubuntu package installs `fdfind`)
if ! command -v fd &>/dev/null; then
  if command -v fdfind &>/dev/null; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    echo "Created symlink: $HOME/.local/bin/fd -> $(command -v fdfind)"
    case ":$PATH:" in
      *":$HOME/.local/bin:"*) ;;
      *) echo "Note: add $HOME/.local/bin to PATH to use 'fd' (or restart your shell)." ;;
    esac
  else
    echo "Neither 'fd' nor 'fdfind' found after install. Check your apt sources."
  fi
fi

# tell pip to trust the Python package servers
PIP_CONF=~/.config/pip/pip.conf
if ! grep -q "^\s*trusted-host" "$PIP_CONF" 2>/dev/null; then
  echo "Pip Configuration not found. Adding it now..."
  # Ensure the directory exists
  mkdir -p "$(dirname "$PIP_CONF")"
  # Append the configuration using a 'here document' for clarity
  cat <<EOF >>"$PIP_CONF"
[global]
trusted-host = pypi.org
               files.pythonhosted.org
               pypi.python.org
EOF
  echo "pip trusted-host configuration has been added to $PIP_CONF."
else
  echo "Pip Configuration already exists. No changes made."
fi

# install coursier for metals (Scala LSP)
# for x86-64 (aka AMD64)
sudo apt install -y openjdk-21-jdk # java 21 lts
if ! command -v cs &>/dev/null; then
  echo "coursier-cli (cs) not found. Installing..."
  curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d >cs
  chmod +x cs
  ./cs setup
  rm cs
else
  # If found, notify the user and exit
  echo "coursier-cli (cs) is already installed."
fi
