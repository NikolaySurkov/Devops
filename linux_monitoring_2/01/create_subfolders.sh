#!/bin/bash
path_for_directory="$1"
str_token_folder="$2"
name_folder=""

name_folder=$(./create_name_folder.sh "${path_for_directory}" "${str_token_folder}" "folder")
status=$?
if [[ status -eq 255 ]] ; then
    echo "${name_folder}"
    exit 255
fi
if mkdir "${name_folder}" 2>/dev/null ; then
    echo "${name_folder}  $(stat -c %y "${name_folder}")" >> log.txt
else
    echo "${name_folder}"
    exit 111
fi
echo "${name_folder}"
exit 0