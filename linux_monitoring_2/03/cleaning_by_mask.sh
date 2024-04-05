#!/bin/bash

# comments

declare red
declare endcolor
declare see_color
declare -i status
declare mask
declare result_search 
declare options
red='\033[31m\033[1m'
endcolor='\033[0m'
see_color='\033[36m\033[5m'

result_search=""
mask=""
options=$*
status=0


count_arg() {
    echo $#
}

_clean_go() {
    local -i number_objects_for_del
    local -i count_line
    number_objects_for_del=0
    count_line=0
    number_objects_for_del=$(echo "${result_search}" | wc -l)
    rm -rf list_result_search.txt
    while [[ count_line -le number_objects_for_del ]] ; do
        rm -rf "$(awk -v n=$count_line 'NR == n {print; exit}'<<<"${result_search}")"

    ##############################################################
        printf "$count_line of $number_objects_for_del\r" 
    ##############################################################

        count_line=$((count_line+1))
    done
    df -h /
}

_checkind_type_mask() {
    local -i number_opt
    number_opt=$(count_arg ${options})

    if [[ number_opt -eq 1 ]] ; then
        status=0
    else
        status=1
    fi

    tocken_mask=$(awk -F "_" '{print $1}'<<<"${options}")
    date_mask=$(awk -F "_" '{print $2}'<<<"${options}")

    if [[ "${tocken_mask}" == "" ]] || [[ $(tr -d 'a-zA-Z'<<<"${tocken_mask}") != "" ]] ; then
        status=1
    fi

    if [[ "${date_mask}" == "" ]] || [[ $(tr -d '0-9'<<<"${date_mask}") != "" ]] ||  [[ ${#date_mask} -ne 6 ]] ; then
        status=1
    fi
}

_set_the_mask() {
    if [[ status -eq 1 ]] ; then
        mask="^.*/[a-zA-Z]{1,}_$(date +%d%m%y)([.]{1}[a-zA-Z]{1,240}){0,1}"
    elif [[ status -eq 0 ]] ; then
        mask="$(./create_regular_mask.sh "${options}")"
    fi
}

_go_search() {
    result_search=$(find /  -regextype posix-extended -regex "${mask}" 2>/dev/null)
}


# MAIN () {
_checkind_type_mask
_set_the_mask
_go_search

if [[ "${result_search}" != "" ]] ; then
    echo -e "${see_color}""search ${red}$(wc -l <<<"$result_search")${see_color} objects${endcolor}"
    answer=""
    read -p "$(echo -e "${see_color}""Do you want to view the files before deleting?${endcolor} ${red}(Y/N)${endcolor}  --> ")" answer

    answer="${answer/Y/y}"

    if [[  "${answer}" == "y" ]] ; then
        echo "${result_search}" > list_result_search.txt
        echo -en "${see_color}""For convenience, an${red} \"list_result_search.txt\"${see_color} file with a list was created"\
        "\nLOOK at it and confirm the deletion${red}(Y/N)${endcolor} -> "
        answer=""
        read -r answer
        answer="${answer/Y/y}"

        if [[  "${answer}" == "y" ]] ; then
            _clean_go
        fi

    else
        _clean_go
    fi

else
    echo -e "${see_color}""search${red} 0${endcolor} ${see_color}objects${endcolor}"
fi

# END }