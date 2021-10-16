#!/bin/bash

# This script generates a list of random passwords
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Three random password numbers together
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Use the current date/time as the basis for the password
PASSWORD=`date +%s`
echo "${PASSWORD}"

# Use nanoseconds to act as randomization
PASSWORD=`date +%s%N`
echo "${PASSWORD}"

# A better password
PASSWORD=`date +%s%N | sha256sum | head -c16`
echo "${PASSWORD}"

# Append a special character to the password
SPECIAL_CHARACTER=`echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1`
echo "${PASSWORD}${SPECIAL_CHARACTER}"