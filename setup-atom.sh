#!/bin/bash

source ./_shared.sh

# Create boilerplate atom config - will overwrite!

apm install firewatch-syntax || die_with_message "Failed executing apm! Exiting."

ATOM_CONFIG_DIR="${HOME}/.atom"
TMP_ATOM_CONFIG=$(mktemp)

echo "\"*\":" >> ${TMP_ATOM_CONFIG}
echo "  core:" >> ${TMP_ATOM_CONFIG}
echo "    telemetryConsent: \"limited\"" >> ${TMP_ATOM_CONFIG}
echo "    themes: [" >> ${TMP_ATOM_CONFIG}
echo "      \"one-dark-ui\"" >> ${TMP_ATOM_CONFIG}
echo "      \"firewatch-syntax\"" >> ${TMP_ATOM_CONFIG}
echo "    ]" >> ${TMP_ATOM_CONFIG}
echo "  editor:" >> ${TMP_ATOM_CONFIG}
echo "    fontSize: 13" >> ${TMP_ATOM_CONFIG}
echo "    lineHeight: 1.35" >> ${TMP_ATOM_CONFIG}
echo "    showInvisibles: true" >> ${TMP_ATOM_CONFIG}
echo "    tabType: \"hard\"" >> ${TMP_ATOM_CONFIG}
echo "  welcome:" >> ${TMP_ATOM_CONFIG}
echo "    showOnStartup: false" >> ${TMP_ATOM_CONFIG}

cp ${TMP_ATOM_CONFIG} ${ATOM_CONFIG_DIR}/config.cson

echo "Finished config!"
exit 0
