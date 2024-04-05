#!/bin/bash

# comments

declare -i count_created_files
declare -i random_number_files
declare -i status_memory
declare name_file
declare type_name_for_create
declare path_for_create_files
declare tokens_for_name_file

count_created_files=0
random_number_files=$(shuf -i 1-100 -n 1)
status_memory=0
name_file=""
type_name_for_create="${3}"
path_for_create_files="${4}"
tokens_for_name_file="${MASSIV_TOKENS_FILENAME:=$1} . ${MASSIV_TOKENS_EXTENTION:=$2}"

_create_a_file_name() {
    local name_file
    local -i count_error_create_name
    name_file=""
    count_error_create_name=0
    while [[ "${name_file}" == "" ]] ; do
        name_file="$(./create_randomname.sh "$@")" 
        count_error_create_name=$((count_error_create_name+1))
        if [[ count_error_create_name -gt 3000 ]] ; then
            echo "error creating subfolder name" 
            exit 22
        fi
    done
    # return
    echo "${name_file}"
}

_create_a_file_fallocate() {
    if   fallocate -l "${SIZE_FILE}" "${name_file}" 2>/dev/null ; then
        echo "${name_file}$(stat -c %y "${name_file}" | awk '{printf "\t%s_%s\t", $1, $2}')$(eval ls -lh "${name_file}"\
        | awk '{print $5}')" >> log.txt
    fi
}

_while_there_is_more_than_one_gb_free_memory() {
    local result
    result="$(./checking_free_memory.sh)"
    if [[ "$result" == "OK" ]] ; then
        status_memory=0
        echo $status_memory
    else 
        status_memory=1
        echo $status_memory
    fi
}

# MAIN() { BEGIN
status_memory=$(_while_there_is_more_than_one_gb_free_memory)

while [[ $count_created_files -le  $random_number_files ]]  && [[ ${status_memory} -eq 0 ]] ; do
    name_file=$(_create_a_file_name "${tokens_for_name_file}" "${type_name_for_create}" "${path_for_create_files}")
    count_created_files=$((count_created_files+1))
    _create_a_file_fallocate
    
    status_memory=$(_while_there_is_more_than_one_gb_free_memory)
done

# return
echo ${status_memory}

# } END