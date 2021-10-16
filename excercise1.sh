#!/bin/bash


# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" != 0 ]]
then
    echo 'You are not root user'
    echo 'Please run with root user'
    exit 1
fi

# Ask for username
read -p 'Enter your username to create: ' USER_NAME

# Ask for realname
read -p 'Enter your real name that will be using this account: ' COMMENT

# Ask for password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the account
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Check to see if the useradd commans succeeded.
if [[ "${?}" != 0 ]]
then
    echo "The account ${USER_NAME} could not be created"
    exit 1
fi

# Set account password
echo "${USER_NAME}":"${PASSWORD}" | chpasswd

# Force change password at the first login.
passwd -e "${USER_NAME}"

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'hostname:'
echo "${HOSTNAME}"