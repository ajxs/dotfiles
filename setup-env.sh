#!/bin/bash

source ./_shared.sh


# Script to setup my personal environment.
if [[ "${__DETECTED_SYSTEM}" == "DEBIAN" ]]; then
	PROGRAMS=("i3" "terminator" "gnome-icon-theme" "thunar" "xclip")
	for PROGRAM in "${PROGRAMS[@]}"; do
		check_install_package "${PROGRAM}"
	done
fi

PROGRAMS=("redshift")
for PROGRAM in "${PROGRAMS[@]}"; do
	check_install_package "${PROGRAM}"
done


echo "Finished setup!"
exit 0
