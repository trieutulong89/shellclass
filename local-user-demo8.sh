#!/bin/bash

# This script demonstrates I/O redirection.

# Redirect STDOUT to a file
FILE="/tmp/data"
head -10 /etc/passwd > "${FILE}"

# Redirect STDIN to a program.
read LINE < "${FILE}"
echo "Line contains: ${LINE}"

# Redirect STDOUT to a file, overwriting the file.
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDOUT to a file, appending to the file.
echo "${RANDOM} ${RANDOM}" >> "${FILE}"
echo "${RANDOM} ${RANDOM}" >> "${FILE}"
echo
echo "Contents of ${FILE}:"
cat "${FILE}"

# Redirect STDIN to a program, using FD 0
read LINE 0< ${FILE}
echo
echo "Line contain: ${LINE}"

# Redirect STDOUT to a file using FD 1, overwriting the file.
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDERR to a file using FD 2.
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fate 2> ${ERR_FILE}

# Redirect STDOUT and STDERR to a file.
head -n3 /etc/passwd /fate &> ${FILE}
echo
echo "Contents of ${FILE}"
cat ${FILE}

# Redirect STDOUT and STDERR through a pipe
echo
head -n3 /etc/passwd /fake |& cat -n

# Send output to STDERR
echo "This is STDERR" >&2

#Discard STDOUT
echo
echo "Discarding STDOU"
head -n3 /etc/passwd /fake > /dev/null


