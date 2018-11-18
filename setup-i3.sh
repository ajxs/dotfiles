#!/bin/bash

source ./_shared.sh

# Script to setup i3.


function print_usage {
  echo "Usage: $0 - Script to set up i3." 1>&2
  exit 0
}

# Script to setup my personal environment.
if [[ "${__DETECTED_SYSTEM__}" == "DEBIAN" ]]; then
  PROGRAMS=("i3" "i3status" "dmenu" "i3lock" "xautolock" "thunar" "gnome-icon-theme" "nm-applet" "volumeicon" "ncdu" "redshift-gtk" "scrot" "xclip" "cpanminus")
elif [[ "${__DETECTED_SYSTEM__}" == "FEDORA" ]]; then
  PROGRAMS=("i3" "i3status" "dmenu" "i3lock" "xautolock" "network-manager-applet" "volumeicon" "ncdu" "redshift-gtk" "scrot" "xclip" "cpanminus" "deluge")
fi

for PROGRAM in "${PROGRAMS[@]}"; do
  check_install_package "${PROGRAM}"
done


# Install screenshot util.
sudo ln -s "${PWD}/i3-screenshot" "/usr/bin/"

# Enable Redshift in Geoclue conf.
GEOCLUE_CONF_FILE="/etc/geoclue/geoclue.conf"
if [[ -f "${GEOCLUE_CONF_FILE}" ]]; then
  # https://unix.stackexchange.com/questions/19707/why-cant-sudo-redirect-stdout-to-etc-file-but-sudo-nano-or-cp-can
  printf "[redshift]\nallowed=true\nsystem=false\nusers=\n" | sudo tee "${GEOCLUE_CONF_FILE}"
fi

echo "Finished setup!"
exit 0
