#!/bin/bash

# comments

declare time_start
declare time_end
declare delta
declare -a parameters
declare tokens_file_main
declare tokens_file_extention
declare token_name_subfolders
declare -x SIZE_FILE
declare -x MASSIV_TOKENS_SUBFOLDER_NAME
declare -x MASSIV_TOKENS_FILENAME
declare -x MASSIV_TOKENS_EXTENTION
declare status_first_check
declare list_of_directories
declare -i number_directories_for_write
declare -i random_number_line
declare -x RANDOM_PATH_DIRECTORY
declare -x SUBFOLDER_NAME
declare -x FILE_NAME


time_start=0
time_end=0
delta=0
parameters=("${@}")
tokens_file_main="$(echo -n "$2" | awk -F "." '{printf "%s", $1}')"
tokens_file_extention="$(echo -n "$2" | awk -F "." '{printf "%s", $2}')"
token_name_subfolders="$1"
SIZE_FILE="$3"
MASSIV_TOKENS_SUBFOLDER_NAME=""
MASSIV_TOKENS_FILENAME=""
MASSIV_TOKENS_EXTENTION=""
status_first_check="OK"
list_of_directories=""
number_directories_for_write=0
random_number_line=0
SUBFOLDER_NAME=""
FILE_NAME=""
RANDOM_PATH_DIRECTORY=""


_converting_a_string_to_an_array() {
   ./string_to_correct_str.sh "${1}"
}

_grant_the_right_to_run_scripts() {
    chmod +x allow_execution.sh
    ./allow_execution.sh
}

_checking_the_correctness_of_the_parameters() {
    ./checking_entered_parameters.sh "${parameters[@]}"
}

_determine_the_start_time_of_the_script() {
    time_start=$(date +%s.%N)
}
_determine_the_end_time_of_the_script() {
    time_end=$(date +%s.%N)
}

_printing_the_script_execution_time() {
    delta=$(bc<<<"scale = 2; $time_end - $time_start" )
    awk '{printf "Script execution time = %.2f sec.\n", $1}' <<<"$delta"
    echo "BEGIN SCRIPT = $(date -d "@$time_start")"  
    echo "END SCRIPT   = $(date -d "@$time_end")" 
}

_create_a_list_of_possible_directories() {
    list_of_directories=$(  find / -perm -664 -type d -writable  2>/dev/null | sed -e 's/$/\//g' -e 's/ /\\ /g') #find /home/ -perm -664 -type d 
    number_directories_for_write=$(echo "$list_of_directories" | wc -l)
}


_while_there_is_more_than_1Gb_of_free_memory() {
    ./checking_free_memory.sh "$@"
}

_checking_the_correctness_of_the_path() {
    ./checking_path.sh 
}

_select_random_directory_to_write_to() {
    status_open=1
    local -i count_error
    count_error=0
    while [ "${status_open}" == "1" ] ; do
        random_number_line=$(shuf -i 1-$number_directories_for_write -n 1)
        RANDOM_PATH_DIRECTORY=$(awk -v n=$random_number_line 'NR == n {print; exit}'<<<"$list_of_directories")
        status_open=1
        count_error=$((count_error+1))
        status_open="$(_checking_the_correctness_of_the_path)"
        if [[ $count_error == 100000 ]] ; then
            df -h /
            _determine_the_end_time_of_the_script
            _printing_the_script_execution_time | tee -a "log.txt"
            exit 11
        fi

    done
}

_create_folders_and_file_in_didectory() {
    ./create_subfolders.sh "${MASSIV_TOKENS_SUBFOLDER_NAME}" "folder" "${RANDOM_PATH_DIRECTORY}"
}


# BEGIN MAIN() {
status_free_memory="$(_while_there_is_more_than_1Gb_of_free_memory "/")"
_determine_the_start_time_of_the_script 
_grant_the_right_to_run_scripts
status_first_check=$(_checking_the_correctness_of_the_parameters)

if [[ "$status_first_check" == "OK" ]] ; then
    _create_a_list_of_possible_directories 

    MASSIV_TOKENS_SUBFOLDER_NAME=$(_converting_a_string_to_an_array "${token_name_subfolders}")
    MASSIV_TOKENS_FILENAME=$(_converting_a_string_to_an_array "${tokens_file_main}")
    MASSIV_TOKENS_EXTENTION=$(_converting_a_string_to_an_array "${tokens_file_extention}")

    while [[ "$status_free_memory" == "OK" ]] ; do
        _select_random_directory_to_write_to
        _create_folders_and_file_in_didectory
        status_free_memory="$(_while_there_is_more_than_1Gb_of_free_memory)"
    done

    echo -e  "${status_free_memory}"

else
    echo "${status_first_check}"
fi

# END }
_determine_the_end_time_of_the_script
_printing_the_script_execution_time | tee -a "log.txt"
