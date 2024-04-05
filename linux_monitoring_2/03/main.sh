#!/bin/bash

declare -i number_argumens
declare arguments
declare status
declare options

red='\033[31m\033[1m'
endcolor='\033[0m'
blue='\033[36m\033[1m'
number_argumens=$#
arguments="$*"
type_clean="${arguments:0:1}"
options="${arguments:1:100}"
status=1
check_type="$(tr -d '1-3'<<<"${type_clean}")"


_help() {
    echo -e "${red}""The script runs with one parameter""${endcolor}"
    echo -e "${blue}""1)./main.sh 1 || ./main.sh 1\"02\" || ./main.sh 1\"01\""
    echo -e "2)./main.sh 2\"yesterday 22:30 yesterday 22:33\" || ./main.sh 2\"231231 23:58 240101 00:03\"  || ./main.sh 2\"2023-09-29 23:58  2023-09-30 00:03\""
    echo -e "3)./main.sh 3 || ./main.sh 3\"asdfgv_311023\"""${endcolor}"
}


_cleaning_first_type() {
    if [[ "${options}" == ""  || "${options}" == "02" ]] ; then
    ./../02/clean_part_2.sh
    elif [[  "${options}" == "01" ]] ; then
        ./../01/clean_part_1.sh
    fi
}


# MAIN() BEGIN {
if [[ number_argumens -eq 1 ]] && [[ "${check_type}" == "" ]] ; then
    status=0
fi

if [[ status -eq 0 ]] ; then

    if [[ "${type_clean}" == "1" ]] ; then
        _cleaning_first_type
    fi

    if [[ "${type_clean}" == "2" ]] ; then

        if [[ -n "${options}"  ]] ; then
            ./cleaning_by_date_and_time.sh "${options}"
            status_checking=$?
            if [[ ${status_checking} -ne 0 ]] ; then
                exit 5
            fi
        else
            answer=""
            read -p "$(echo -e "enter the start and end date and time in the format : yymmdd hhmm yymmdd hhmm"\
            "\nexample 1: \"231031 2358 231101 0003\""\
            "\nexample 2: \"yesterday 23:58 today 00:03\":   > ")" answer
            ./cleaning_by_date_and_time.sh "${answer}"
        fi

    fi

    if [[ ${type_clean} == "3" ]] ; then
        ./cleaning_by_mask.sh "${options}"
        status_checking=$?
        if [[ ${status_checking} -ne 0 ]] ; then
            exit 5
        fi
    fi

else
    _help
fi

# END }
