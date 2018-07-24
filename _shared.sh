#!/bin/bash

# check if a package is installed, and install it if not.
function check_install_package {
	echo "Not implemented for this OS."
	exit 1
}


# Apply OS-specific overloads

if [ -f "/etc/arch-release" ]; then
	source ./shared.arch.sh
elif [ -f "/etc/lsb-release" ]; then
	source ./shared.deb.sh
elif [ "$(uname)" = "Darwin" ]; then
	source ./shared.osx.sh
fi


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
