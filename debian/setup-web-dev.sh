#!/bin/bash

source ./_shared.deb.sh


# Script to setup web dev environment.

# Install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# Reload shell, then install node
source ~/.bashrc
nvm install 9


echo "Finished setup!"
exit 0
