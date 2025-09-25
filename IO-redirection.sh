#!/bin/bash

# Redirect STDOUT to a file
FILE="./data.txt"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

