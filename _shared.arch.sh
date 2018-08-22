#!/bin/bash

# check if a package is installed, and install it if not.
function check_install_package {
	local PKG_NAME="${1}"
	if pacman -Qs "${PKG_NAME}" > /dev/null; then
		echo "${PKG_NAME} is already installed."
	else
		echo "Intalling ${PKG_NAME}."
		sudo pacman -S "${PKG_NAME}"
	fi
}


# Takes a screenshot and copies it to the clipboard.
function screenshot_region_to_clipboard {
	./screenshot.py --region
}
