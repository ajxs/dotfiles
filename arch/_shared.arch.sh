#!/bin/bash

function die_with_message {
	echo "$1" >&2
	exit 1
}


function prompt_to_confirm {
  read -n 1 -p "Please press ENTER to confirm." var
  if [ ${#var} -ne 0 ]; then
    echo "Aborted."
    exit 0
  fi
}


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