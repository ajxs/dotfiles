GECKODRIVER_VERSION=0.19.1
ARCHIVE_NAME="geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz"

GECKODRIVER_URL="https://github.com/mozilla/geckodriver/releases/download/v${GECKODRIVER_VERSION}/${ARCHIVE_NAME}"

# check if we have a local downloaded copy already
DOWNLOAD_DIR="${HOME}/Downloads"
LOCAL_DOWNLOADED_COPY="${DOWNLOAD_DIR}/${ARCHIVE_NAME}"

TEMP_DIR="$(mktemp -d)"

if [ -e ${LOCAL_DOWNLOADED_COPY} ]; then
	echo "Found local copy of tar at ${LOCAL_DOWNLOADED_COPY}..."
	LOCAL_FILE="${LOCAL_DOWNLOADED_COPY}"
else
	echo "Downloading from ${CROSS_COMPILER_TAR_URL} to ${TEMP_DIR}..."
	wget "${GECKODRIVER_URL}" -P "${TEMP_DIR}"
	LOCAL_FILE="${TEMP_DIR}/${ARCHIVE_NAME}"
	echo "Downloaded to ${LOCAL_FILE}"
fi

echo "Extracting archive to ${LOCAL_FILE}..."
tar xf "${LOCAL_FILE}" -C "${TEMP_DIR}" || die_with_message "Failure Unzipping archive! Exiting."
echo "Archive extraction complete."

tar -xvzf "${LOCAL_FILE}"
chmod +x "${TEMP_DIR}/geckodriver"
sudo cp "${TEMP_DIR}/geckodriver" "/usr/local/bin/"
