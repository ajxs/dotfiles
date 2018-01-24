die_with_message() {
	echo "$1"
	exit 1
}

# check if a package is installed, and install it if not.
check_install_package() {
	PKG_NAME="${1}"
	PKG_STATUS=$(dpkg-query -W --showformat='${Status}\n' ${PKG_NAME} | grep "install ok installed")
	if [ "" == "$PKG_STATUS" ]; then
		echo "Intalling ${PKG_NAME}."
		sudo apt-get --yes install "${PKG_NAME}"
	else
		echo "${PKG_NAME} is already installed."
	fi
}


check_for_local_download() {
	FILE_URL="${1}"
	if [ -z "${FILE_URL}" ]; then
		exit 1
	fi

	FILE_NAME="${FILE_URL##*/}"

	DOWNLOAD_DIR="${HOME}/Downloads"
	LOCAL_DOWNLOADED_COPY="${DOWNLOAD_DIR}/${FILE_NAME}"

	# check if we have a local downloaded copy already
	if [ -e ${LOCAL_DOWNLOADED_COPY} ]; then
		echo ${LOCAL_DOWNLOADED_COPY}
	else
		TEMP_DIR="$(mktemp -d)"
		wget -q "${FILE_URL}" -P "${TEMP_DIR}" || exit 1
		echo ${TEMP_DIR}/${FILE_NAME}
	fi
}


install_tar_to_usr_bin() {
	TAR_URL="${1}"
	USR_BIN_PATH="/usr/local/bin"
	echo "Installing from ${TAR_URL} to ${USR_BIN_PATH}..."

	LOCAL_FILE=$(check_for_local_download "${TAR_URL}")
	ARCHIVE_NAME="${LOCAL_FILE##*/}"

	TEMP_DIR="$(mktemp -d)"
	echo "Extracting archive to ${TEMP_DIR}..."
	tar xf "${LOCAL_FILE}" -C "${TEMP_DIR}" || die_with_message "Failure Unzipping archive! Exiting."
	echo "Archive extraction complete."

	chmod +x "${TEMP_DIR}/."
	sudo cp -a "${TEMP_DIR}/." "${USR_BIN_PATH}"
	echo "Completed installation of ${ARCHIVE_NAME}"
}
