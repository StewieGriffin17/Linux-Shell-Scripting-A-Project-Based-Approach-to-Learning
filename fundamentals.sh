#!/bin/bash

# Basic fundamentals of shell scripting

echo 'hello'

WORD='script'

echo "$WORD"

echo "This is a shell $WORD"

echo "${WORD}ing is fun!"


# Display the uid
echo "Your uid is ${UID}"

# Display the username
USER_NAME=$(id -un)
echo "Your username is $USER_NAME"

# Display if the user is the root or not
if [[ "${UID}" -eq 0 ]]
then
	echo "You are root user."
else
	echo "You are not the root user."
fi

TEST_USER_NAME='asif'

if [[ "${USER_NAME}" = "${TEST_USER_NAME}" ]]
then
	echo "Your username matches ${TEST_USER_NAME}"
fi

