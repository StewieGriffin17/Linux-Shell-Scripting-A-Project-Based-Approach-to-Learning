#!/bin/bash
# This script creates a new user account on the local system.


# Checks if the user is root or not.
if [[ "${UID}" -ne 0 ]]
then 
	echo 'Please run with sudo or as root.'
	exit 1
fi

# Checks if the user provided required arguments or not.
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT]..."
	echo 'Create an account on the local system with the name of USER_NAME and a comments field of COMMENT.'
	exit 1
fi

# First parameter is the user name.
USER_NAME="${1}"

# Rest of the parameters are for the account comment.
shift
COMMENT="${@}"

# Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c16) 

# Create new user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Checks if the useradd command succeeded or not.
if [[ "${?}" -ne 0 ]]
then
	echo 'The account could not be created.' 
	exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME} 

# Checks if the passwd command succeeded or not.
if [[ "${?}" -ne 0 ]]
then
	echo 'The password could not be set.'
	exit 1
fi

# Force password change on first login
passwd -e ${USER_NAME}

# Display the username, password and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo 
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"

exit 0




