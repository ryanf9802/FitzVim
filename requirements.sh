#!/bin/bash

sudo apt update

# install coursier for metals (Scala LSP)
# for x86-64 (aka AMD64)
sudo apt install openjdk-21-jdk # java 21 lts
curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
chmod +x cs
./cs setup
sudo rm cs
