#!/bin/bash

source ./_shared.sh

GECKODRIVER_VERSION=v0.19.1
ARCHIVE_NAME="geckodriver-${GECKODRIVER_VERSION}-linux64.tar.gz"
GECKODRIVER_URL="https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/${ARCHIVE_NAME}"

install_tar_to_usr_bin "${GECKODRIVER_URL}"
