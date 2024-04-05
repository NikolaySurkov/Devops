#!/bin/bash

# comments

declare -i status_open
declare  dir_path

dir_path=""
status_open=1


_checking_one() {
    dir_path=$(readlink -f "${RANDOM_PATH_DIRECTORY}")
    if [[  -f "${dir_path}" ]] ; then
        echo 1
        exit 22
    elif [[ $status_open == 1 ]] ; then 
        status_open=0
    fi
}

_checking_two() {
    if [[ ! -d "${dir_path}" ]] ; then
        echo 1
        exit 22
    elif [[ $status_open == 1 ]] ; then
        status_open=0
    fi
}

_checking_three() {
    if [ ! -w "${RANDOM_PATH_DIRECTORY}" ] ; then
        echo 1
        exit 22
    elif [[ $status_open == 1 ]] ; then
        status_open=0
    fi
}

_checking_four() {
    if [ ! -r "${RANDOM_PATH_DIRECTORY}" ] ; then
        echo 1
        exit 22
    elif [[ $status_open == 1 ]] ; then
        status_open=0
    fi
}

_checking_five() {
    dir_path=$(echo "${RANDOM_PATH_DIRECTORY}" | grep  -e /bin/ -e /sbin/ )
    if [[ "${dir_path}" != "" ]] ; then
        echo 1
        exit 22
    elif [[ $status_open == 1 ]] ; then
        status_open=0
    fi
}

_checking_six() {
    if [[ $(./checking_free_memory.sh "${RANDOM_PATH_DIRECTORY}") != "OK" ]] ; then
        echo 1
        exit 22
    fi
}

_return_function() {
    if [[ $status_open == 0 ]] ; then
        echo "${RANDOM_PATH_DIRECTORY}"
    fi
}


# MAIN {
_checking_one
_checking_two
_checking_three
_checking_four
_checking_five
_checking_six
_return_function
# }