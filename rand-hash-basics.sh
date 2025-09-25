#!/bin/bash

# Generating a random number as a password. 
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Three random numbers
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Use the current date/time as the basis for the password.
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# Generating a better password using sha256sum hasing
PASSWORD=$(date +%s | sha256sum | head -c12)
echo "${PASSWORD}"

# Generating a password with a random speacial character
SPECIAL_CH=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CH}"
