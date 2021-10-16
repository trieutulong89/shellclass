#!/bin/bash

# Script creates a new user on the local system
# You must supply a username as an argument to the script
#Optionally, you can also provide a comment for the account as a argument

# Check if the user execute this script is not root user
if [[ "${UID}" != 0 ]]
then
    echo "Please run script ${0} as root user"
    exit 1
fi

# Check if user not provice argument
if [[ "${#}" -lt 1 ]]
then
    echo "Usage ${0}: USER_NAME [COMMENT]..."
    echo "Create an account on the local system with the name of USER_NAME and a comment field of COMMENT"
    exit 1
fi

# The first parameter is the username
USER_NAME="${1}"

# The rest of the parameters are for the account comments.
shift
COMMENT="${@}"

# Generate a password
PASSWORD=`date +%s%N | sha256sum | head -c48`

# Create user with password
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Notify the user that an account was created when it hasn't been
if [[ "${?}" -ne 0 ]]
then
    echo "The account could not be created."
    exit 1
fi

# Set password for account
echo "${USER_NAME}":"${PASSWORD}" | chpasswd

# Check to see if the password command succeeded.
if [[ "${?}" -ne 0 ]]
then
    echo 'The password for the account could not be set'
    exit 1
fi

# Force password change on the first login.
passwd -e "${USER_NAME}"

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
