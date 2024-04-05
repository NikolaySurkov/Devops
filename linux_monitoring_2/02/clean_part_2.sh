#!/bin/bash

# comments
path_logfile="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/log.txt"

if [[ ! -e "$path_logfile"  ]] ; then
    echo "\"$path_logfile\" was not found. Run main.sh + 3 parameters."
else
    echo "cleaning the system from created files..."
    cat < "$path_logfile" | while read -r line ; do
        sudo rm -rf "$(echo "${line}" | awk '{print $1}')"
    done
    answer=""
    echo "delete \"$path_logfile\"?"
    read -r  answer
    answer="${answer//Y/y}"
    if [[ $answer == "y" ]] ; then
        rm -rf "$path_logfile"
    fi
    echo "System cleanup is complete"
    df -h /
fi
