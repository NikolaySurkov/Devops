#!/bin/bash  
declare -i number_arg
declare length_arg
declare argument
declare -i status

declare folder_run
declare folder_info
declare folder_logs
declare files
declare -i number_files
declare statistic

statistic=""
number_arg=$#
length_arg=${#*}
argument="${*}"
status=0

folder_run=""
folder_info=""
folder_logs=""
files=""
number_files=""

count_arg() {
    echo $#
}

_path_determinant() {
    folder_run="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/"
    folder_info="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/info/"
    folder_logs="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/../04/logs/"
}

_checking_arg() {
    if [[ number_arg -ne 1 && length_arg -ne 1 ]] ; then 
        echo -e "The script is run with 1 parameter, which has a value of 1, 2, 3 or 4"
        echo -e "[1] All entries sorted by response code"
        echo -e "[2] All unique IPs found in the entries"
        echo -e "[3] All requests with errors (response code - 4xx or 5xxx)"
        echo -e "[4] All unique IPs found among the erroneous requests"
        status=1
    else
        if [[ $argument -lt 1 || $argument -gt 4 ]] ; then
            echo "argument from 1 to 4"
            status=1
        fi
    fi
}

_suggest_running_the_script() {
    read -r  answer
    if [[ "$answer" == "y" ]] ; then
        bash "$folder_run../04/main.sh"
        status=0
        files=$(ls "$folder_logs" 2>/dev/null )
        number_files=$(count_arg ${files})
    else 
        exit 1
    fi
}

_checking_files() {
    files=$(ls "$folder_logs" 2>/dev/null )
    number_files=$(count_arg ${files})

    if [[ number_files -eq 0 ]] ; then
        status=1
        answer=""
        echo "There are no log files for parsing"
        echo "Run a script to create logs?"
        _suggest_running_the_script
    fi
}

_print_statistic() {
    list_files=$(tr -s "\n" " " <<< "${1}")
    echo -e "\nLog Source: ${list_files}"
    awk -f "${folder_run}"statistic.awk ${2}
}

_create_subfolder() {
    if [[ ! -d "$1" ]] ; then
        mkdir "${1}"
    fi
}

# MAIN() { BEGIN
_checking_arg
_path_determinant
_checking_files
if [[ $status -eq 0 ]]; then
    _create_subfolder "${folder_info}"
    if [[ "$argument" == "1" ]] ; then
        awk -F "&" '{print $2}'<<< " $(awk -f "${folder_run}"sort_error_codes.awk "${folder_run}"../04/logs/*.log)"  > "${folder_info}${argument}_sort_codes_all_logs.txt"
        _create_subfolder "${folder_info}0${argument}"
        for file in ${files} ; do
            name="$(awk -F "." '{print $1}' <<< "${file}")"
            awk -F "&" '{print $2}'<<< " $(awk -f "${folder_run}"sort_error_codes.awk "${folder_run}"../04/logs/"${file}")"  > "${folder_info}0${argument}/${argument}_$name.txt"
            statistic+=$(_print_statistic "${file}" "${folder_run}"../04/logs/"${file}")
        done
    elif [[ "$argument" == "2" ]] ; then
        awk -f "${folder_run}"uniq_ip_all.awk  "${folder_run}"../04/logs/*.log > "${folder_info}${argument}_uniq_ip_all_logs.txt"
        _create_subfolder "${folder_info}0${argument}"
        for file in ${files} ; do
            name="$(awk -F "." '{print $1}' <<< "${file}")"
            awk -f "${folder_run}"uniq_ip_all.awk  "${folder_run}"../04/logs/"${file}"  > "${folder_info}0${argument}/${argument}_$name.txt"
            statistic+=$(_print_statistic "${file}" "${folder_run}"../04/logs/"${file}")
        done
    elif [[ "$argument" == "3" ]] ; then
        awk -f "${folder_run}"error_codes.awk "${folder_run}"../04/logs/*.log  >"${folder_info}${argument}_only_errorcodes_all_logs.txt"
        _create_subfolder "${folder_info}0${argument}"
        for file in ${files} ; do
            name="$(awk -F "." '{print $1}' <<< "${file}")"
            awk -f "${folder_run}"error_codes.awk "${folder_run}"../04/logs/"${file}"  > "${folder_info}0${argument}/${argument}_$name.txt"
            statistic+=$(_print_statistic "${file}" "${folder_run}"../04/logs/"${file}")
        done
    elif [[ "$argument" == "4" ]] ; then
        awk -f "${folder_run}"uniq_ip_error_codes.awk "${folder_run}"../04/logs/*.log > "${folder_info}${argument}_uniq_ip_errorcodes_all_logs.txt"
        _create_subfolder "${folder_info}0${argument}"
        for file in ${files} ; do
            name="$(awk -F "." '{print $1}' <<< "${file}")"
            awk -f "${folder_run}"uniq_ip_error_codes.awk "${folder_run}"../04/logs/"${file}"  > "${folder_info}0${argument}/${argument}_$name.txt"
            statistic+=$(_print_statistic "${file}" "${folder_run}"../04/logs/"${file}")
        done
    fi
    statistic+=$(_print_statistic "${files}" "${folder_run}../04/logs/*.log")
    echo -e "${statistic:1}" > "${folder_info}statistic.txt"
fi
# END }