#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
    echo "Please run script: ${0} as root user" >&2
    exit 1
fi

# Check if user not provide argument
if [[ "${#}" -lt 1 ]]
then
    echo "Usage ${0}: USER_NAME COMMENT..." >&2
    echo "Create a local username with USER_NAME and a comment field with COMMENT."
    exit 1
fi

USER_NAME="${1}"
shift
COMMENT="${@}"
PASSWORD=`date +%s%N | sha256sum | head -c48` &> /dev/null

# Create user
useradd -c "${COMMENT}" -m "${USER_NAME}" &> /dev/null

# Check if user successfuly create.
if [[ "${?}" -ne 0 ]]
then
    echo "User is not created" >&2
    exit 1
fi

#Force password change on first login
passwd -e ${USER_NAME} &> /dev/null

#Display username, password and host

echo "Username is crated is: ${USER_NAME}"
echo "Password for user ${USER_NAME} is ${PASSWORD}"
echo "Hostname is ${HOSTNAME}"