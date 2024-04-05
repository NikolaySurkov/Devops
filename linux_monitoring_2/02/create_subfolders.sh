#!/bin/bash

# comments

declare name_subfolder
declare type_name_for_create
declare path_for_create_subfolders
declare tokens_for_name_subfolder
declare -i random_number_subfolders
declare -i counter_created_subfolders
declare -i status_m

name_subfolder=""
type_name_for_create="${2}"
path_for_create_subfolders="${RANDOM_PATH_DIRECTORY:="${3}"}"
tokens_for_name_subfolder="${MASSIV_TOKENS_SUBFOLDER_NAME:="${1}"}"
random_number_subfolders=$(shuf -i 1-100 -n 1)
counter_created_subfolders=0
status_m=0

_create_a_subfolder_name() {
    local name_subfolder
    local -i count_error_create_name
    name_subfolder=""
    count_error_create_name=0
    while [[ "${name_subfolder}" == "" ]] ; do
        name_subfolder="$(./create_randomname.sh "$@")" 
        count_error_create_name=$((count_error_create_name+1))
        if [[ count_error_create_name -gt 3000 ]] ; then
            echo "error creating subfolder name" 
            exit 22
        fi
    done
    if [[ -n "${name_subfolder}" ]] ; then
        echo "${name_subfolder}"
    fi
}

_create_a_folder_mkdir() {

    if mkdir -p   "${name_subfolder}" 2>/dev/null ; then
        echo "${name_subfolder}$(stat -c %y "${name_subfolder}" | awk '{printf "\t%s_%s\t", $1, $2}')$(eval ls -lh "${name_subfolder}"\
        | awk '{print $5}')" >> log.txt
    fi
}

_create_files_in_subfolder() {
    status_m=$(./create_files.sh "$@")
    if [[ status_m -ne 0 ]] ; then
        exit 33
    fi
}


# MAIN() { BEGIN
while [[ $counter_created_subfolders -le  $random_number_subfolders ]] ; do
    name_subfolder=$(_create_a_subfolder_name "${tokens_for_name_subfolder}" "${type_name_for_create}" "${path_for_create_subfolders}")
    counter_created_subfolders=$((counter_created_subfolders+1))
    _create_a_folder_mkdir
    
    _create_files_in_subfolder "${MASSIV_TOKENS_FILENAME:="h a m l e t "}" "${MASSIV_TOKENS_EXTENTION:="y e s "}"  "file"  "${name_subfolder}"
done


# } END
