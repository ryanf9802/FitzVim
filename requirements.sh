#!/bin/bash

sudo apt update

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
