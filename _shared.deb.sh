# check if a package is installed, and install it if not.
function check_install_package {
	local pkg_name="${1}"
	local pkg_status=$(dpkg-query -W --showformat='${Status}\n' ${pkg_name} | grep "install ok installed")
	if [ "" == "$pkg_status" ]; then
		echo "Intalling ${pkg_name}."
		sudo apt-get --yes install "${pkg_name}"
	else
		echo "${pkg_name} is already installed."
	fi
}
