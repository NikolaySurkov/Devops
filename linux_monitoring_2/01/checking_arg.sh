#!/bin/bash

red='\033[31m'
endcolor='\033[0m'
status_checking=0

numbers_arguments=$#
path_for_create="$1"
number_subfolders="$2"
letters_for_folders="$3"
number_files="$4"
letters_for_files_all="$5"
size_file="$(eval echo "${6}" | sed -e 's/kb/kb/I')"

filename=${letters_for_files_all%.*}
filename_extension=${letters_for_files_all#*.}

# 0
if [[ $numbers_arguments -ne 6 ]]; then
    echo -e "${red}""The number of arguments must be equal to 6.""${endcolor}"
    status_checking=3
    exit 1
fi
# 1
if [[ "${path_for_create:-1}"  != "/" ]] ; then 
    path_for_create+="/"
fi
dir_path=$(readlink -f "${path_for_create}")
if [[  -f "${dir_path}" ]]; then
    echo -e "$path_for_create\n${red}This is the absolute path to the file.\
    \nPlease specify the absolute path to the folder you need in the first argument!""${endcolor}"
    exit 1
elif [[ ! -d "${dir_path}" ]]; then
    status_checking=1
    echo -e "${red}""The first argument, you introduced some nonsense.\
    \nPlease don't do this anymore!\
    \nThe first argument must contain the absolute path to the folder you need.""${endcolor}"
    exit 1
fi
if [ ! -w "$path_for_create" ]; then
    echo -e "$path_for_create\n${red}There are not enough rights to write to the specified directory""${endcolor}"
    exit 1
fi

# 2
strcheck=$(echo -n "$number_subfolders" | tr -d 0-9) 
if [[ -n "$strcheck" ]] || [[  $number_subfolders -lt 1 ]]; then
    echo -e "${red}""The second argument is the number of subfolders.\
    \nIt must be a positive number from 1 to ...""${endcolor}"
    status_checking=2
    exit 2
fi

# 3
strcheck=$(echo -n "$letters_for_folders" | tr -d '[:upper:][:lower:]') 
string_length=$(echo -n "$letters_for_folders" | wc -c)
if [[ -n "$strcheck" ]] || [[  $string_length -gt 7 ]]; then
    echo -e "${red}""The third argument should contain only Latin letters for folder names.\
    \nThe maximum allowed number of characters is seven..""${endcolor}"
    status_checking=3
    exit 3
fi

#4
strcheck=$(echo -n "$number_files" | tr -d  0-9) 
if [[ -n "$strcheck" ]] || [[  $number_files -lt 1 ]]; then
    echo -e "${red}""The fourth argument is the number of files for each subfolder.\
    \nIt must be a positive number from 1 to ...""${endcolor}"
    status_checking=4
    exit 4
fi

#5
strcheck=$(echo -n "$letters_for_files_all" | tr -d '[:upper:][:lower:]')
string_length_all=$(echo -n "$letters_for_files_all" | wc -c)
string_length_name=$(echo -n "$filename" | wc -c)
string_length_extension=$(echo -n "$filename_extension" | wc -c)


if [[ "$strcheck" != "." ]] || [[  $string_length_all -gt 11 ]]; then
    echo -e "${red}""The fifth argument must contain only Latin letters, and one dot.\
    \nThe length of the name is no more than 7 characters.\
    \nThe extension length is no more than 3 characters.""${endcolor}"
    status_checking=5
    exit 5
fi

if [[  $string_length_name -lt 1  ||  $string_length_name -gt 7 ]]; then
    echo -e "${red}""The length of the file name should not exceed 7 characters and not less than one.""${endcolor}"
    status_checking=5
    exit 5
fi

if [[  $string_length_extension -gt 3 || $string_length_extension -lt 1 ]]; then 
    echo -e "${red}""The length of the file extension must be no more than 3 characters and at least one.""${endcolor}"
    status_checking=5
    exit 5
fi

#6
strcheck=$(echo -n "$size_file" | tr -d 0-9) 
if [[ "$strcheck" != "kb" ]]; then
    echo -e "${red}""The sixth argument is the file size(KB).\
    \nIts value must be a positive number from 1 to 100 + kb(1kb)""${endcolor}"
    status_checking=6
    exit 6
fi
strcheck=$(echo -n "$size_file" | tr -d "kb")
if [[ $strcheck -lt 1 ]] || [[  $strcheck -gt 100 ]]; then
    echo -e "${red}""The sixth argument(size file): Its value must be a positive number from 1 to 100""${endcolor}"
    status_checking=6
    exit 6
fi

# status OK
if [[ $status_checking -eq 0 ]]; then
    echo "OK"
fi