#!/bin/bash

source ./_shared.sh

# Script to build qemu from latest src
# Rationale is qemu-system-arm in Xenial repo is 2.5.0
# which doesn't support raspi2 emulation

TAR_URL="https://download.qemu.org/qemu-2.11.0.tar.xz"
ARCHIVE_NAME="${TAR_URL##*/}"

ARCHIVE_DIR_NAME="$(basename ${ARCHIVE_NAME} .tar.xz)"

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

echo "Extracting archive to ${TEMP_DIR}/${LOCAL_FILE}..."
tar xf "${LOCAL_FILE}" -C "${TEMP_DIR}" || die_with_message "Failure Unzipping archive! Exiting."

cd "${TEMP_DIR}/${ARCHIVE_DIR_NAME}"

DEPENDENCIES=("libglib2.0-dev" "zlib1g-dev" "libfdt-dev" "libpixman-1-dev")
for PACKAGE in "${DEPENDENCIES[@]}"; do
	check_install_package "${PACKAGE}"
done

source ./configure
sudo make && sudo make install
