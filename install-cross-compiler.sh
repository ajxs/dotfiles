#!/bin/bash

source ./_shared.sh

# Script to download and install cross-compilers
# This script will download the script tar, unzip it to a local install directory
# then add the bin path to your environment vars.

print_usage() {
	echo "Usage: $0 [-c <string>]" 1>&2
	exit 1
}


ENV_VAR_CFG="${HOME}/.bashrc"

I686_ELF_GCC_URL="http://newos.org/toolchains/i686-elf-4.9.1-Linux-x86_64.tar.xz"
I686_ELF_GCC_DIR="i686-elf-4.9.1-Linux-x86_64"

ARM_NONE_EABI_GCC_URL="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/6-2017q2/gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2"
ARM_NONE_EABI_GCC_DIR="gcc-arm-none-eabi-6-2017-q2-update"


while getopts ":c:" o; do
	case "${o}" in
		c)
			CROSS_COMPILER=${OPTARG}
		;;
		*)
			print_usage
		;;
	esac
done
shift $((OPTIND-1))

if [ -z "${CROSS_COMPILER}" ]; then
	print_usage
fi

case ${CROSS_COMPILER} in
	"i686-elf-gcc")
		CROSS_COMPILER_TAR_URL="${I686_ELF_GCC_URL}"
		# we need to hardcode UNZIPPED_DIR_NAME unfortunately, some may vary from tar name
		UNZIPPED_DIR_NAME="${I686_ELF_GCC_DIR}"
		;;
	"arm-none-eabi-gcc")
		CROSS_COMPILER_TAR_URL="${ARM_NONE_EABI_GCC_URL}"
		UNZIPPED_DIR_NAME="${ARM_NONE_EABI_GCC_DIR}"
		;;
	*)
		echo "Unknown cross compiler args! Exiting."
		exit 1
	;;
esac


echo "Installing ${CROSS_COMPILER} cross-compiler..."

# create local install directory
LOCAL_INSTALL_DIR="${HOME}/opt/cross"
if [ ! -d "${LOCAL_INSTALL_DIR}" ]; then
	mkdir -p "${LOCAL_INSTALL_DIR}" || die_with_message "Failure creating install directory! Exiting."
	echo "Created installation dir at: ${LOCAL_INSTALL_DIR}"
else
	echo "installation dir already found at: ${LOCAL_INSTALL_DIR}"
fi


LOCAL_FILENAME="${CROSS_COMPILER_TAR_URL##*/}"
FULL_DEST_DIR="${LOCAL_INSTALL_DIR}/${UNZIPPED_DIR_NAME}"

if [ -d "${FULL_DEST_DIR}" ]; then
	die_with_message "Cross compiler install target directory already exists! Exiting."
fi


# check if we have a local downloaded copy already - useful for testing
LOCAL_FILE=$(check_for_local_download "${CROSS_COMPILER_TAR_URL}") || die_with_message "Failed to download/locate package! Exiting."

echo "Extracting archive to ${FULL_DEST_DIR}..."
tar xf "${LOCAL_FILE}" -C "${LOCAL_INSTALL_DIR}" || die_with_message "Failure Unzipping archive! Exiting."
echo "Archive extraction complete."

# export bin directory to environment vars
BIN_PATH_STRING="${FULL_DEST_DIR}/bin"
printf "\nexport PATH=\$PATH:${BIN_PATH_STRING}\n" >> "${ENV_VAR_CFG}"
echo "Exported ${BIN_PATH_STRING} to \$PATH."

echo "Reloading env cfg..."
exec bash

echo "Finished installation!"
exit 0
