#!/bin/bash

sudo apt update

# tell pip to trust the Python package servers
PIP_CONF=~/.config/pip/pip.conf
if ! grep -q "^\s*trusted-host" "$PIP_CONF" 2>/dev/null; then
  echo "Pip Configuration not found. Adding it now..."
  # Ensure the directory exists
  mkdir -p "$(dirname "$PIP_CONF")"
  # Append the configuration using a 'here document' for clarity
  cat << EOF >> "$PIP_CONF"
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
sudo apt install openjdk-21-jdk # java 21 lts
if ! command -v cs &> /dev/null
then
    echo "coursier-cli (cs) not found. Installing..."
    curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
    chmod +x cs
    ./cs setup
    rm cs
else
    # If found, notify the user and exit
    echo "coursier-cli (cs) is already installed."
fi
