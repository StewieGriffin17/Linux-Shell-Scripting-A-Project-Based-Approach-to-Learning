#!/bin/bash
# This script creates a new user account on the local system.

# Check if the user is root
if [[ "${UID}" -ne 0 ]]; then
    echo 'Please run with sudo or as root.' >&2
    exit 1
fi

# Check if the user provided at least one argument
if [[ "${#}" -lt 1 ]]; then
    echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
    echo 'Create an account on the local system with the name of USER_NAME and a comments field of COMMENT.' >&2
    exit 1
fi

# First parameter is the user name
USER_NAME="${1}"

# The rest of the parameters are for the account comment
shift
COMMENT="${@}"

# Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c16)

# Create the new user with home directory and comment
if ! useradd -c "${COMMENT}" -m "${USER_NAME}"; then
    echo 'The account could not be created.' >&2
    exit 1
fi

# Set the password using chpasswd
echo "${USER_NAME}:${PASSWORD}" | chpasswd
if [[ "${?}" -ne 0 ]]; then
    echo 'The password could not be set.' >&2
    exit 1
fi

# Force password change on first login
passwd -e "${USER_NAME}" &> /dev/null

# Display the username, password, and host
echo "username: ${USER_NAME}"
echo "password: ${PASSWORD}"
echo "host: ${HOSTNAME}"

exit 0




