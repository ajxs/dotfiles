#!/bin/bash

source ./_shared.deb.sh


# Script to setup git and apply my personal configuration options.

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
git config --global alias.cm "commit -m"
git config --global alias.st "status"
git config --global alias.aa "add -A"
git config --global alias.uc "reset HEAD~"

# misc

git config --global push.default simple

echo "Finished setup!"
exit 0
