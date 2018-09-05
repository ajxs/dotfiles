#!/bin/bash

# check if a package is installed, and install it if not.
function check_install_package {
	echo "Not implemented for this OS."
	exit 1
}


function die_with_message {
	echo "$1" >&2
	exit 1
}


function append_to_bashrc() {
	local TEXT="$1"
	local BASHRC="${HOME}/.bashrc"

	printf "%s\\n" "${TEXT}" >> "${BASHRC}"
}


# Global var for referencing in subsequent scripts to check the OS.
__DETECTED_SYSTEM__=""


# Apply OS-specific overloads
if [ -f "/etc/arch-release" ]; then
	source ./_shared.arch.sh
	__DETECTED_SYSTEM__="ARCH"
elif [ -f "/etc/lsb-release" ]; then
	source ./_shared.deb.sh
	__DETECTED_SYSTEM__="DEBIAN"
elif [ "$(uname)" = "Darwin" ]; then
	source ./_shared.osx.sh
	__DETECTED_SYSTEM__="OSX"
else
	die_with_message "Unable to determine Operating System! Exiting."
fi


function prompt_to_confirm {
	read -n 1 -p "Please press ENTER to confirm." var
	if [ ${#var} -ne 0 ]; then
		echo "Aborted."
		exit 0
	fi
}


# Check if a file has been downloaded to the user's download directory, otherwise download it.
function check_for_local_download {
	local FILE_URL="${1}"
	if [ -z "${FILE_URL}" ]; then
		echo "No URL passed to check_for_local_download()! Exiting." >&2
		exit 1
	fi

	local FILE_NAME="${FILE_URL##*/}"
	local DOWNLOAD_DIR="${HOME}/Downloads"
	local LOCAL_DOWNLOADED_COPY="${DOWNLOAD_DIR}/${FILE_NAME}"

	# check if we have a local downloaded copy already
	if [ -e ${LOCAL_DOWNLOADED_COPY} ]; then
		echo "Using local copy found at ${LOCAL_DOWNLOADED_COPY}." >&2
		echo ${LOCAL_DOWNLOADED_COPY}
	else
		local TEMP_DIR="$(mktemp -d)"
		echo "No local copy found. Downloading from ${FILE_URL}..." >&2
		wget -q "${FILE_URL}" -P "${TEMP_DIR}" || die_with_message "Failure downloading ${FILE_URL}! Exiting."
		echo ${TEMP_DIR}/${FILE_NAME}
	fi
}


# http://stefaanlippens.net/pretty-csv.html
function view_csv {
	# column -t -s, -n "$@" | less -F -S -X -K
	perl -pe 's/((?<=\t)|(?<=^))\t/ \t/g;' "$@" | column -t -s $'\t' | less	-F -S -X -K
}


# Takes a screenshot and copies it to the clipboard.
function screenshot_region_to_clipboard {
	echo "Not implemented for this OS."
	exit 1
}
