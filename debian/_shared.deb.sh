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
	local PKG_STATUS=$(dpkg-query -W --showformat='${Status}\n' ${PKG_NAME} | grep "install ok installed")
	if [ "" == "$PKG_STATUS" ]; then
		echo "Intalling ${PKG_NAME}."
		sudo apt-get --yes install "${PKG_NAME}"
	else
		echo "${PKG_NAME} is already installed."
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


function install_tar_to_usr_bin {
	local TAR_URL="${1}"
	local USR_BIN_PATH="/usr/local/bin"
	echo "Installing from ${TAR_URL} to ${USR_BIN_PATH}..."

	local LOCAL_FILE=$(check_for_local_download "${TAR_URL}")
	local ARCHIVE_NAME="${LOCAL_FILE##*/}"

	local TEMP_DIR="$(mktemp -d)"
	echo "Extracting archive to ${TEMP_DIR}..."
	tar xf "${LOCAL_FILE}" -C "${TEMP_DIR}" || die_with_message "Failure Unzipping archive! Exiting."
	echo "Archive extraction complete."

	chmod +x "${TEMP_DIR}/."
	sudo cp -a "${TEMP_DIR}/." "${USR_BIN_PATH}"
	echo "Completed installation of ${ARCHIVE_NAME}"
}

# http://stefaanlippens.net/pretty-csv.html
function view_csv {
	# column -t -s, -n "$@" | less -F -S -X -K
	perl -pe 's/((?<=\t)|(?<=^))\t/ \t/g;' "$@" | column -t -s $'\t' | less  -F -S -X -K
}
