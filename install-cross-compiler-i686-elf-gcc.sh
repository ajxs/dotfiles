# Script to download and install an i686-elf-gcc cross-compiler
# This script will download the script tar, unzip it to a local install directory
# then add the bin path to your environment vars

echo "Installing i686-elf-gcc cross-compiler..."

CROSS_COMPILER_TAR_URL="http://newos.org/toolchains/i686-elf-4.9.1-Linux-x86_64.tar.xz"

ENV_VAR_CFG="${HOME}/.bashrc"

# create local install directory
LOCAL_INSTALL_DIR="${HOME}/opt/cross"
if [ ! -d "${LOCAL_INSTALL_DIR}" ]; then
	mkdir -p "${LOCAL_INSTALL_DIR}"
	MKDIR_STATUS=$?
	if [ ${MKDIR_STATUS} -ne 0 ]; then
		echo "Failure creating install directory... exiting"
		exit
	fi
fi
echo "Created installation dir at: ${LOCAL_INSTALL_DIR}"


TEMP_DIR="$(mktemp -d)"

echo "Downloading compiler from ${CROSS_COMPILER_TAR_URL} to ${TEMP_DIR}..."
wget "${CROSS_COMPILER_TAR_URL}" -P "${TEMP_DIR}"
WGET_STATUS=$?
if [ ${WGET_STATUS} -ne 0 ]; then
	echo "Failure downloading archive... exiting"
	exit
fi


LOCAL_FILENAME="$(basename ${CROSS_COMPILER_TAR_URL})"
LOCAL_FILE="${TEMP_DIR}/${LOCAL_FILENAME}"
echo "Downloaded to ${LOCAL_FILE}"


tar xf "${LOCAL_FILE}" -C "${LOCAL_INSTALL_DIR}"
TAR_EXIT_CODE=$?
if [ ${TAR_EXIT_CODE} -ne 0 ]; then
	echo "Failure Unzipping archive... exiting"
	exit
fi

# tar contains a folder with a matching filename
UNZIPPED_DIR_NAME=$(basename ${LOCAL_FILENAME} .tar.xz)
FULL_DEST_DIR="${LOCAL_INSTALL_DIR}/${UNZIPPED_DIR_NAME}"

echo "Unzipped to ${FULL_DEST_DIR}"

# export bin directory to environment vars
BIN_PATH_STRING="${FULL_DEST_DIR}/bin"
printf "\nexport PATH=\$PATH:${BIN_PATH_STRING}\n" >> "${ENV_VAR_CFG}"
echo "exported ${BIN_PATH_STRING} to \$PATH"

echo "Reloading env cfg..."
source ${ENV_VAR_CFG}

echo "Finished installation!"
