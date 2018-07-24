#!/bin/bash

# check if a package is installed, and install it if not.
function check_install_package {
	local PKG_NAME="${1}"
	local PKG_STATUS=$(dpkg-query -W --showformat='${Status}\n' ${PKG_NAME} | grep "install ok installed")
	if [ "" == "$PKG_STATUS" ]; then
		echo "Intalling ${PKG_NAME}."
		sudo apt-get --yes install "${PKG_NAME}"
	else
		echo "${PKG_NAME} is already installed."
	fi
}