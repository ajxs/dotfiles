#!/bin/bash

# Place overloaded functions at the start of this file.
# These are files that will be overloaded by the OS specific script files.

# check if a package is installed, and install it if not.
function check_install_package {
	echo "Not implemented for this OS."
	exit 1
}


function append_to_bashrc() {
	local text="$1"
	local bashrc="${HOME}/.bashrc"

	printf "%s\\n" "${text}" >> "${bashrc}"
}


function append_to_PATH() {
	local dir="$1"
	local path_prefix='PATH=$PATH:'

	append_to_bashrc "${path_prefix}${dir}"
}


# Apply OS-specific overloads
current_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
if [ -f "/etc/arch-release" ]; then
	source "${current_dir}/_shared.arch.sh"
	detected_system="ARCH"
elif [ -f "/etc/lsb-release" ]; then
	source "${current_dir}/_shared.deb.sh"
	detected_system="DEBIAN"
elif [ -f "/etc/redhat-release" ]; then
	source "${current_dir}/_shared.fedora.sh"
	detected_system="FEDORA"
elif [ "$(uname)" = "Darwin" ]; then
	source "${current_dir}/_shared.osx.sh"
	detected_system="OSX"
else
	(>&2 echo "Unable to determine Operating System! Not applying any OS specific overrides.")
fi


function die_with_message {
	echo "$1" >&2
	exit 1
}


function prompt_to_confirm {
	read -n 1 -p "Please press ENTER to confirm." var
	if [ ${#var} -ne 0 ]; then
		echo "Aborted."
		exit 0
	fi
}


# Check if a file has been downloaded to the user's download directory, otherwise download it.
function check_for_local_download {
	local file_url="${1}"
	if [ -z "${file_url}" ]; then
		echo "No URL passed to check_for_local_download()! Exiting." >&2
		exit 1
	fi

	local file_name="${file_url##*/}"
	local download_dir="${HOME}/Downloads"
	local local_downloaded_copy="${download_dir}/${file_name}"

	# check if we have a local downloaded copy already
	if [ -e ${local_downloaded_copy} ]; then
		echo "Using local copy found at ${local_downloaded_copy}." >&2
		echo ${local_downloaded_copy}
	else
		local tmp_dir="$(mktemp -d)"
		echo "No local copy found. Downloading from ${file_url}..." >&2
		wget -q "${file_url}" -P "${tmp_dir}" || die_with_message "Failure downloading ${file_url}! Exiting."
		echo ${tmp_dir}/${file_name}
	fi
}


# http://stefaanlippens.net/pretty-csv.html
function view_csv {
	# column -t -s, -n "$@" | less -F -S -X -K
	perl -pe 's/((?<=\t)|(?<=^))\t/ \t/g;' "$@" | column -t -s $'\t' | less	-F -S -X -K
}
