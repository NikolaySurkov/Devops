#!/bin/bash


status_check=0
# ARGUMENTS="${@}"
path_for_directory="$1"
subfolder_number=$2
subfolder_pattern="$3"
FILE_NUMBER=$4
file_pattern="$5"
file_size_all="$6"
file_size=0
type_size=""
count_folder=0
str_token_folder=""
str_token_file=""
str_extention=""
status=0

status_check=$(./checking_arg.sh "${@}")
str_token_folder=""
str_token_file=""

permit() {
    chmod +x permit_run.sh
    ./permit_run.sh
}

create_massiv_patterns() {
    str_token_folder=$(./create_massiv_str.sh "${subfolder_pattern}")
    str_token_file=$(./create_massiv_str.sh "${file_pattern%.*}")
    str_extention=$(./create_massiv_str.sh "${file_pattern#*.}")
}

create_subfolders() {
    name_folder=$(./create_subfolders.sh "$path_for_directory" "$str_token_folder")
    status=$?
    ####################################################
    printf "${count_folder} of ${subfolder_number}\r" ##
    ####################################################
}

create_file() {
    file_pattern=$(./create_file.sh "$name_folder" "$str_token_file . $str_extention" "file" "${FILE_NUMBER}" "${file_size}" "${type_size}")
    status=$?
    if [ $status -eq 9 ] ; then
        echo "$file_pattern"
        exit 99
    else
        str_token_file=$(echo "${file_pattern}" | awk -F "." '{print $1}')
        str_extention=$(echo "${file_pattern}" | awk -F "." '{print $2}')
    fi
    count_folder=$((count_folder + 1))

}


additional_recording_of_patterns() {
    ./additional_recording_of_patterns.sh "$1"
}

memory_check_status() {
    memory=$(./checking_memory_free.sh "$path_for_directory")
    if [[ "$memory" != "OK" ]] ; then
        echo "$memory"
        exit 9
    fi
}


if [[ "$status_check" == "OK" ]] ; then
    if [[ "${path_for_directory:-1}"  != "/" ]] ; then 
        path_for_directory+="/"
    fi
    file_size=$(echo "${file_size_all}" | tr -d "[:upper:][:lower:]")
    type_size=$(echo "${file_size_all}" | tr -d '[:digit:]' | sed -e 's/kb/K/I')
    create_massiv_patterns
    while [ $count_folder -lt  "${subfolder_number}" ] ; do
        create_subfolders
        if [[ $status -eq 255 ]] ; then
            echo "$name_folder"
            name_folder=""
            str_token_folder="$(eval ./additional_recording_of_patterns.sh "${subfolder_pattern}")"
            name_folder=$(./create_name_folder.sh "$path_for_directory" "$str_token_folder" "folder")
        elif [[ $status -eq 0 ]] ; then
            create_file
        fi
        memory_check_status
    done
else 
    echo "$status_check" 
fi 
