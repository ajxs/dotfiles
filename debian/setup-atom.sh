#!/bin/bash

source ./_shared.deb.sh

# script to configure Atom editor

# Install user packages
PACKAGES=("firewatch-syntax" "language-x86-64-assembly" "git-blame")
for PACKAGE in "${PACKAGES[@]}"; do
	apm install "${PACKAGE}" || die_with_message "Failed executing apm! Exiting."
done

# Create boilerplate atom config - will overwrite!

ATOM_CONFIG_DIR="${HOME}/.atom"
cp "./_data/atom_config.cson" ${ATOM_CONFIG_DIR}/config.cson

echo "Finished config!"
exit 0
