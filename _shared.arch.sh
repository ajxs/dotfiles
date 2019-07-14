# check if a package is installed, and install it if not.
function check_install_package {
	local pkg_name="${1}"
	if pacman -Qs "${pkg_name}" > /dev/null; then
		echo "${pkg_name} is already installed."
	else
		echo "Intalling ${pkg_name}."
		sudo pacman -S "${pkg_name}"
	fi
}
