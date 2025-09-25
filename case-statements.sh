#!/bin/bash


# Demonstration of the case statement.

#case "${1}" in
#	start)
#		echo 'Starting'
#		;;
#	stop)
#		echo 'Stopping'
#		;;
#	status|state)
#		echo 'Status: '
#		;;
#	*)
#		echo 'Supply a valid option.' >&2
#		exit 1
#		;;
#esac


# Function demonstration

#log(){
#	local MESSAGE="${@}"
#	echo "${MESSAGE}"
#}

#log 'Hello!'
#log 'This is fun!'


# Random password generate

usage(){
	echo "USAGE: ${0} [-vs] [-l LENGTH]" >&2
	echo 'Generate a random password.'
	echo ' -l LENGTH    Specify the password length.'
	echo ' -s 	    Append a special character to the password.'
	echo ' -v	    Increase verbosity.'
	exit 1
}

display(){
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi	
}

LENGTH=16

while getopts vl:s OPTION
do
	case ${OPTION} in
		v)
			VERBOSE='true'
			display 'Verbose mode on.'
			;;
		l)
			LENGTH="${OPTARG}"
			;;
		s)
			SPEICAL_CHAR='true'
			;;
		?)
			usage
			;;
	esac
done

display 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

if [[ "${SPECIAL_CHAR}" = 'true' ]]
then
	display 'Selecting a random special character.'
	SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)
	PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

display 'DONE'
display 'Here is the password - '

echo "${PASSWORD}"

exit 0




