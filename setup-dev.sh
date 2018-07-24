#!/bin/bash

source ./_shared.deb.sh


# Script to setup dev tools.

PROGRAMS=("gcc-multilib")
for PROGRAM in "${PROGRAMS[@]}"; do
	check_install_package "${PROGRAM}"
done

# Install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# Reload shell, then install node
source ~/.bashrc
nvm install 9


echo "Finished setup!"
exit 0
