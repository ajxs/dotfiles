#!/bin/bash

source ./_shared.sh


# Script to setup dev tools.

PROGRAMS=("gcc-multilib" "cpanm")
for PROGRAM in "${PROGRAMS[@]}"; do
	check_install_package "${PROGRAM}"
done

# perldoc comes loaded with Perl on Arch.
if [[ "${__DETECTED_SYSTEM__}" != "ARCH" ]]; then
	check_install_package "perl-doc"
fi


# Install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# Reload shell, then install node
source ${HOME}/.bashrc
nvm install 9


# Install pip
curl -o- https://bootstrap.pypa.io/get-pip.py | sudo python


echo "Finished setup!"
exit 0
