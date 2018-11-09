#!/bin/bash

# check if a package is installed, and install it if not.
function check_install_package {
	local PKG_NAME="${1}"
	if dnf -q list installed "${PKG_NAME}" > /dev/null; then
		echo "${PKG_NAME} is already installed."
	else
		echo "Intalling ${PKG_NAME}."
		sudo dnf -y install "${PKG_NAME}"
	fi
}