#!/bin/bash

source ./_shared.deb.sh

# Script to build qemu from latest src
# Rationale is qemu-system-arm in Xenial repo is 2.0.0
# which doesn't support raspi2 emulation

TAR_URL="https://download.qemu.org/qemu-2.11.1.tar.xz"
LOCAL_FILE=$(check_for_local_download "${TAR_URL}")

ARCHIVE_NAME="${LOCAL_FILE##*/}"
ARCHIVE_DIR_NAME="$(basename ${ARCHIVE_NAME} .tar.xz)"

TEMP_DIR="$(mktemp -d)"
echo "Extracting archive to ${TEMP_DIR}..."
tar xf "${LOCAL_FILE}" -C "${TEMP_DIR}" || die_with_message "Failure Unzipping archive! Exiting."

cd "${TEMP_DIR}/${ARCHIVE_DIR_NAME}"

DEPENDENCIES=("libglib2.0-dev" "zlib1g-dev" "libfdt-dev" "libpixman-1-dev")
for PACKAGE in "${DEPENDENCIES[@]}"; do
	check_install_package "${PACKAGE}"
done

./configure --enable-fdt
sudo make -j$(nproc) && sudo make install
