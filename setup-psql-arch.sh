#!/bin/bash

source ./_shared.sh


# perldoc comes loaded with Perl on Arch.
if [[ "${__DETECTED_SYSTEM__}" != "ARCH" ]]; then
	die_with_message "Script intended to be run on ARCH! Exiting."
fi

check_install_package "postgresql"

# Setup postgres data dir.
PSQL_DATA_DIR="/var/lib/postgres/data"

sudo mkdir "${PSQL_DATA_DIR}"
sudo chmod 775 "${PSQL_DATA_DIR}"
sudo chown postgres "${PSQL_DATA_DIR}"

# Postgres init.
sudo -u postgres -i initdb --locale en_US.UTF-8 -E UTF8 -D ${PSQL_DATA_DIR}
sudo -u postgres -i pg_ctl -D ${PSQL_DATA_DIR} -l logfile start

# Start service.
sudo systemctl enable postgresql.service
sudo systemctl start postgresql.service