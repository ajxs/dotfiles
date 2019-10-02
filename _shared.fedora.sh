# check if a package is installed, and install it if not.
function check_install_package {
	local pkg_name="${1}"
	if dnf -q list installed "${pkg_name}" > /dev/null; then
		echo "${pkg_name} is already installed."
	else
		echo "Intalling ${pkg_name}."
		sudo dnf -y install "${pkg_name}"
	fi
}
