#!/bin/bash

log() {
    local VERBOSE="${1}" >&2
    shift
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
    logger -t local-user-demo10.sh "${MESSAGE}"
}

readonly VERBOSE='true'

log "${VERBOSE}" 'Hello!'
log "${VERBOSE}" 'This is fun!'