#!/bin/bash

# script for creating a random file name or a subfolder name
# first     - string with letters for name
# second    - type name (subfolder or file)
# third     - path for checking name 

declare -i number_token_name
declare -i random_number_begin
declare -i random_number_end
declare -i random_number_letter
declare -i count_letters
declare tokens_for_name
declare name_object
declare actual_date_for_name
declare -i length_object_name
declare -i length_name_before_date
declare -i length_name_after_dot
declare -i MAX_LENGTH_OBJECT_NAME
declare type_name
declare path_to_object

# declare -f _exit_in_case_of_an_error
# declare -f _determine_the_number_of_name_tokens
# declare -f _assigning_values_to_variables
# declare -f _glue_the_current_date_to_the_name
# declare -f _checking_the_length_of_the_name
# declare -f _glue_the_path_with_the_name
# declare -f _is_there_an_object_with_this_name

_exit_in_case_of_an_error() {
    name_object=""
    path_to_object=""
    echo "${name_object}"
    exit 3
}

_determine_the_number_of_name_tokens() {
    local str_tokens="${1}"
    local type_name="${2}"
    local -i number_token_name
    number_token_name=$(echo -n "$str_tokens" | tr -d '[:upper:][:lower:].' | wc -c)

    if [[ "${type_name}" == "file" ]] ; then
        number_token_name=$((number_token_name-1))
    fi

    # return
    echo ${number_token_name}
}

_assigning_values_to_variables() {
    number_token_name=$(_determine_the_number_of_name_tokens "${1}" "${2}")
    random_number_begin=1
    random_number_end=$((248 / number_token_name))
    random_number_letter=1
    count_letters=0
    tokens_for_name="${1}"
    name_object=""
    actual_date_for_name="_$(date +%D | awk -F'/' '{print $2$1$3}')"
    type_name="${2}"
    length_object_name=0
    length_name_before_date=0
    length_name_after_dot=0
    MAX_LENGTH_OBJECT_NAME=255
    path_to_object="${3}"
}

_glue_the_current_date_to_the_name() {
    name_object+="${actual_date_for_name}"
}

_checking_the_length_of_the_name() {
    if [[ "${type_name}" == "file" ]] ; then
        length_name_after_dot=$(echo -n "${name_object#*.}" | wc -c)
        if [ ${length_name_after_dot} -le 0 ] ; then
            _exit_in_case_of_an_error
        fi
    fi
    length_object_name="${#name_object}"
    if [ ${length_object_name} -gt ${MAX_LENGTH_OBJECT_NAME} ] ; then
        _exit_in_case_of_an_error
    fi
    length_name_before_date=$(echo -n "${name_object%_*}" | wc -c)
    if [ ${length_name_before_date} -lt 5 ] ; then
        _exit_in_case_of_an_error
    fi
}

_glue_the_path_with_the_name() {
    if [[ "${type_name}" == "folder" ]] ; then
        path_to_object+="${name_object}/"
    else
        path_to_object+="${name_object}"
    fi
}

_is_there_an_object_with_this_name() {
    check_path=$(readlink -f "${path_to_object}")
    if [[ "${type_name}" == "folder" ]] ; then
        if [[ -d "${check_path}" ]] ; then 
            _exit_in_case_of_an_error
        fi
    else
        if [[ -f "${check_path}" ]] ; then 
            _exit_in_case_of_an_error
        fi
        if [[ -e "${check_path}" ]] ; then 
            _exit_in_case_of_an_error
        fi
    fi
}


# MAIN() BEGIN {
_assigning_values_to_variables "${@}"

for letter_token in ${tokens_for_name} ; do
    random_number_letter=$(shuf -i $random_number_begin-$random_number_end -n 1)

    count_letters=0

    if [[ "${letter_token}" == "." ]] ; then
        _glue_the_current_date_to_the_name
        name_object+=$letter_token
        count_letters=$random_number_letter
    fi

    while [ ${count_letters} -lt ${random_number_letter} ] ; do
        name_object+=$letter_token
        count_letters=$((count_letters+1))
    done
done

if [[ "${type_name}" == "folder" ]] ; then
    _glue_the_current_date_to_the_name
fi

_checking_the_length_of_the_name
_glue_the_path_with_the_name
_is_there_an_object_with_this_name

# return
echo "${path_to_object}"

# } END
