#!/bin/bash

# Script to setup git

die_with_message() {
	echo "$1"
	exit 1
}

# check if a package is installed, and install it if not.
check_install_package() {
	CHECK_PACKAGE="${1}"
	dpkg -s "${CHECK_PACKAGE}" > /dev/null 2>&1
	INSTALL_STATUS="$?"
	if [ "${INSTALL_STATUS}" -ne 0 ]; then
		sudo apt-get install "${CHECK_PACKAGE}" --yes || die_with_message "Installation failed"
	else
		echo "${CHECK_PACKAGE} is already installed!"
	fi
}

PROGRAMS=("git" "vim")
for PROGRAM in "${PROGRAMS[@]}"; do
	check_install_package "${PROGRAM}"
done

# set default git editor
git config --global core.editor "vim"

# set up git identity
git config --global user.email "ajxscc@gmail.com"
git config --global user.name "Anthony"

# setup git aliases
git config --global alias.cam "commit -am"
git config --global alias.st "status"
git config --global alias.aa "add -A"
git config --global alias.uc "reset HEAD~"

echo "Finished setup!"
exit 0
