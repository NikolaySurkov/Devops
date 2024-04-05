#!/bin/bash

# comments

declare red='\033[31m'
declare endcolor='\033[0m'
declare green="\e[3;90m"

declare number_parameters
declare tokens_subfolders
declare tokens_file_entirely
declare tokens_file_extention
declare str_length_file_main
declare str_length_file_extention
declare size_files_entirely
declare -i size_files_value
declare status_check

number_parameters=$#
tokens_subfolders="$1"
tokens_file_entirely="$2"
tokens_file_extention="$(echo -n "$2" | awk -F "." '{printf "%s", $2}')"
str_length_file_main=$(echo -n "$tokens_file_entirely" | awk -F "." '{printf "%s", $1}' | wc -c)
str_length_file_extention=$(echo -ne "$tokens_file_entirely" | awk -F "." '{printf "%s", $2}'| wc -c)
size_files_entirely="$(echo "${3}" | sed -e 's/mb/Mb/I')"
size_files_value=$(echo "${size_files_entirely}" | tr -d "[:upper:][:lower:]")
status_check=0

_checking_the_number_of_parameters() {
    if [ $number_parameters -ne 3 ] ; then
        echo -e "${red}""The number of arguments must be equal to 3.""${endcolor}"
        echo -e "${green}""Parameter 1 is a list of English alphabet letters used in folder names (no more than 7 characters).""${endcolor}"
        echo -e "${green}""Parameter 2 the list of English alphabet letters used in the file name and extension\
        \n(no more than 7 characters for the name, no more than 3 characters for the extension).""${endcolor}" 
        echo -e "${green}""Parameter 3 - is the file size (in Megabytes, but not more than 100).""${endcolor}"
        status_check=-1
        exit 4
    fi
}

_checking_the_first_parameter() {
    string_without_letters=$(echo -n "${tokens_subfolders}" | tr -d "[:upper:][:lower:]") 
    string_length=$(echo -n "${tokens_subfolders}" | wc -c)
    
    if [[ -n "${string_without_letters}" ]] || [[ $string_length -gt 7 ]] ; then
        echo -e "${red}""The first argument should contain only Latin letters for subfolder names.\
        \nThe maximum allowed number of characters is seven...""${endcolor}"
        status_check=1
        exit 1
    fi
}

_checking_the_second_parameter() {
    string_with_point=$(echo -n "${tokens_file_entirely}" | tr -d "[:upper:][:lower:]") 
    if [[ "$string_with_point" != "." ]] ; then
        echo -e "${red}""The second argument must contain only Latin letters, and one dot.\
        \nThe length of the name is no more than 7 characters.\
        \nThe extension length is no more than 3 characters.""${endcolor}"
        status_check=2
        exit 2
    fi

    if [[  $str_length_file_main -lt 1  ||  $str_length_file_main -gt 7 ]] ; then
        echo -e "${red}""The length of the file name should not exceed 7 characters and not less than one.""${endcolor}"
        status_check=2
        exit 2
    fi

    if [[  $str_length_file_extention -gt 3 || $str_length_file_extention -lt 1 ]] ; then 
        echo -e "${red}""The length of the file extension must be no more than 3 characters and at least one.""${endcolor}"
        echo "$str_length_file_extention |$tokens_file_extention|"
        status_check=2
        exit 2
    fi
}

_checking_the_third_parameter() {
    string_with_mb=$(echo -n "${size_files_entirely}" | tr -d 0-9) 
    if [[ "$string_with_mb" != "Mb" ]] ; then
        echo -e "${red}""The third argument is the file size(MB).\
        \nIts value must be a positive number from 1 to 100 + mb(1mb)""${endcolor}"
        status_check=3
        exit 3
    fi

    if [[ $size_files_value -lt 1 ]] || [[  $size_files_value -gt 100 ]] ; then
        echo -e "${red}""The third argument(size file): Its value must be a positive number from 1 to 100(11mb)""${endcolor}"
        status_check=3
        exit 3
    fi
}

_checking_the_number_of_parameters
_checking_the_first_parameter
_checking_the_second_parameter
_checking_the_third_parameter

# status OK
if [[ $status_check -eq 0 ]] ; then
    echo -n "OK"
    exit 0
fi