#!/bin/bash

source ./_shared.sh

# Script to setup i3 on fedora.


function print_usage {
  echo "Usage: $0 - Script to set up i3 on fedora." 1>&2
  exit 0
}

PROGRAMS=("i3" "i3status" "dmenu" "i3lock" "xbacklight" "xautolock" "feh" "conky" "nm-applet" "volumeicon")
for PROGRAM in "${PROGRAMS[@]}"; do
	check_install_package "${PROGRAM}"
done