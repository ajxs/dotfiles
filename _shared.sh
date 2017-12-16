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


install_tar_to_usr_bin() {
	TAR_URL="${1}"
	USR_BIN_PATH="/usr/local/bin"

	ARCHIVE_NAME="${TAR_URL##*/}"

	# check if we have a local downloaded copy already
	DOWNLOAD_DIR="${HOME}/Downloads"
	LOCAL_DOWNLOADED_COPY="${DOWNLOAD_DIR}/${ARCHIVE_NAME}"

	TEMP_DIR="$(mktemp -d)"

	if [ -e ${LOCAL_DOWNLOADED_COPY} ]; then
		echo "Found local copy of tar at ${LOCAL_DOWNLOADED_COPY}..."
		LOCAL_FILE="${LOCAL_DOWNLOADED_COPY}"
	else
		echo "Downloading from ${CROSS_COMPILER_TAR_URL} to ${TEMP_DIR}..."
		wget "${TAR_URL}" -P "${TEMP_DIR}" || die_with_message "Failure downloading archive! Exiting."
		LOCAL_FILE="${TEMP_DIR}/${ARCHIVE_NAME}"
		echo "Downloaded to ${LOCAL_FILE}"
	fi

	echo "Extracting archive to ${LOCAL_FILE}..."
	tar xf "${LOCAL_FILE}" -C "${TEMP_DIR}" || die_with_message "Failure Unzipping archive! Exiting."
	echo "Archive extraction complete."

	chmod +x "${TEMP_DIR}/."
	sudo cp -a "${TEMP_DIR}/." "${USR_BIN_PATH}"
	echo "Completed installation of ${ARCHIVE_NAME}"
}
