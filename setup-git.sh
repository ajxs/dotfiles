#!/bin/bash

source ./_shared.sh

# Script to setup git and apply my personal configuration options.


function print_usage {
  echo "Usage: $0 -e|--email 'git_email@here.com' - Script to set up git config." 1>&2
  exit 0
}


GIT_EMAIL=""

while [[ $# -gt 0 ]]; do
  key="${1}"

  case $key in
    -e|--email)
    GIT_EMAIL=${2}
    shift
    ;;
    -h|--help)
    print_usage
    exit 0
    shift
    ;;
    *)
    shift
    ;;
  esac
done


[[ -n "$GIT_EMAIL" ]] || die_with_message "No --email arg set! Exiting."

echo "Configuring git user for '${GIT_EMAIL}'"

# If not already present, generate RSA key.s
if [[ ! -f "${HOME}/.ssh/id_rsa" ]]; then
	ssh-keygen -t rsa -b 4096 -C "${GIT_EMAIL}"
fi

PROGRAMS=("git" "vim")
for PROGRAM in "${PROGRAMS[@]}"; do
	check_install_package "${PROGRAM}"
done

# set default git editor
git config --global core.editor "vim"

# set up git identity
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "Anthony"

# setup git aliases
git config --global alias.cam "commit -am"
git config --global alias.cm "commit -m"
git config --global alias.st "status"
git config --global alias.aa "add -A"
git config --global alias.uc "reset HEAD~"

# misc

git config --global push.default simple

echo "Finished setup!"
exit 0
