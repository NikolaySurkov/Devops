#!/bin/bash

declare red
declare endcolor
declare see_color
declare optind
declare -i status
declare date_clean_begin
declare date_clean_end
declare time_begin
declare time_end
declare time_begin_clean
declare time_end_clean
declare result_search_file
declare result_search_folder
declare -i number_opt

red='\033[31m\033[1m'
endcolor='\033[0m'
see_color='\033[36m\033[1m'
optind=$*
status=0
result_search_folder=""
result_search_file=""

count_arg() {
    echo $#
}

_info_print() {
    if [[ "${result_search_folder}"  != ""  || "${result_search_file}" != "" ]] ; then
        echo "$result_search_file" > search_file.txt
        echo "$result_search_folder" > search_subfolder.txt
        echo -e "${see_color}Review the files ${red}\"search_file.txt\" ${see_color}and ${red}\"search_subfolder.txt\""\
        " ${see_color}and if there are no files necessary for the correct operation of the system,"\
        " confirm the deletion. Otherwise, use a different cleaning method.${endcolor}"\
        "\n${see_color}type ${red}(f) ${see_color}to delete only files."\
        "\ntype ${red}(s) ${see_color}to delete subfolders.."\
        "\ntype ${red}(a) ${see_color}to delete all objects..."\
        "\ntype ${red}(n) ${see_color}to cancel!""${endcolor}"
    else
        echo -e "${see_color}""search${red} 0${endcolor} ${see_color}objects${endcolor}"
        rm -rf *.txt
        exit 0
    fi
}

_clean_go_date() {
    local -i number_objects_for_del
    local -i count_line
    number_objects_for_del=0
    count_line=0
    number_objects_for_del=$(echo "${1}" | wc -l)
    rm -rf *.txt
    while [[ count_line -le number_objects_for_del ]] ; do
        rm -rf "$(awk -v n=$count_line 'NR == n {print; exit}'<<<"${1}")"

    ##################################################################################
        printf "$count_line of $number_objects_for_del\r" 
    ##################################################################################

        count_line=$((count_line+1))
    done
    df -h /
}


_clearing_by_date_and_time() {
    local answer
    answer=""
    read -r answer
    if [[ "${answer}" == "f" ]] ; then
        _clean_go_date "${result_search_file}"
    elif  [[ "${answer}" == "s" ]] ; then
        _clean_go_date "${result_search_folder}"
    elif [[ "${answer}" == "a" ]] ; then
        _clean_go_date "${result_search_file}"
        _clean_go_date "${result_search_folder}"
    else
       echo  "exit..."
       exit 0
    fi
}


_collecting_information() {
    if [[ status -eq 0 ]] ; then
        ep1=$(date +%s --date="$time_begin_clean")
        ep2=$(date +%s --date="$time_end_clean")

        if [[ ep1 -ge ep2 ]] ; then
            echo -e "${red}The initial time point of deletion is greater than or equal to the final one${endcolor}"
            exit 3
        else
            answer=""
            delta=$(bc<<<"scale = 2; $ep2 - $ep1" )
            awk '{printf "'"${see_color}"'So, you want to delete all objects created in'"${endcolor}"' "\
            "'"${red}"'%.f'"${endcolor}"''"${see_color}"' seconds from'"${endcolor}"' "\
            "'"${red}"'%s'"${endcolor}"' '"${see_color}"'to'"${endcolor}"' "\
            "'"${red}"'%s'"${endcolor}"'\n", $1, $2" " $3, $4" "$5}' <<<"$delta $time_begin_clean $time_end_clean"
            read -p "$(echo -e "${see_color}Type yes${red} (Y)${endcolor}${see_color}"\
            "to confirm or another character to cancel and press ENTER:${endcolor}   ->  ")" answer
            answer="${answer/Y/y}"
            aa="$(date '+%Y-%m-%d %H:%M:%S' -d "@${ep1}")"
            bb="$(date '+%Y-%m-%d %H:%M:%S' -d "@${ep2}")"

            if [[ "$answer" == "y" ]] ; then
                result_search_file=$(find /  -type f    -newermt "$aa" ! -newermt "$bb" -print 2>/dev/null) # -not -path "/sys/*" -not -path "/proc/*" -not -path "/run/*" -not -path "/bin/*" -not -path "/var/*"
                result_search_folder=$(find /  -type d    -newermt "$aa" ! -newermt "$bb" -print 2>/dev/null)
                _info_print
            else
                exit 7
            fi

        fi

    else
        exit 4
    fi
}


_checking_date_and_time() {
    local date_time_clean
    local date
    local time
    date="${1}"
    time="${2}"
    if date_time_clean=$(date +'%Y-%m-%d %H:%M ' -d "${date} ${time}"  2>&1); then 
        status=0
        echo -n "${date_time_clean}"
    else 
        echo "ERROR: ${date} $time"
        status=1
        exit 3
    fi
}


_checkind_type_date_time() {
    number_opt=$(count_arg ${optind})
    if [[ number_opt -eq 4 ]] ; then
        date_clean_begin=$(awk '{print $1}'<<<"${optind}")
        date_clean_end=$(awk '{print $3}'<<<"${optind}")
        time_begin=$(awk '{print $2}'<<<"${optind}")
        time_end=$(awk '{print $4}'<<<"${optind}")
        time_begin_clean=""
        time_end_clean=""

        if ! time_begin_clean=$(_checking_date_and_time "${date_clean_begin} ${time_begin}"); then
            echo "${time_begin_clean}"
            exit 9
        fi

        if ! time_end_clean=$(_checking_date_and_time "${date_clean_end} ${time_end}"); then
            echo "${time_end_clean}"
            exit 9
        fi
    else
        echo "Error  yymmdd hhmm yymmdd hhmm"
        exit 2
    fi
}

# MAIN () BEGIN { 
_checkind_type_date_time
_collecting_information
_clearing_by_date_and_time
# } END
