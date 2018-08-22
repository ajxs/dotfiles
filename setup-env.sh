#!/bin/bash

source ./_shared.sh


# Script to setup my personal environment.

PROGRAMS=("i3" "terminator" "gnome-icon-theme" "thunar" "cpanm" "xclip" "perl-doc")
for PROGRAM in "${PROGRAMS[@]}"; do
	check_install_package "${PROGRAM}"
done


echo "Finished setup!"
exit 0
