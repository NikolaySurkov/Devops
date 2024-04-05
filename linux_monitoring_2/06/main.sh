#!/bin/bash

declare folder_logs
declare -i status
declare folder_run
declare folder_logs
declare number_arg

number_arg=${#}
folder_run=""
folder_logs=""
status=0
folder_logs=""

_path_determinant() {
    folder_run="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/"
    folder_logs="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/../04/logs/"
}

count_arg() {
    echo $#
}

_suggest_running_the_script() {
    read -r  answer
    if [[ "$answer" == "y" ]] ; then
        bash "$folder_run"../04/main.sh
        
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
    bash "$folder_run"../05/main.sh 1
}


# MAIN () { BEGIN
if [[ $number_arg -ne 0 ]] ; then
    status=1
    echo "The script runs without arguments"
else
    _path_determinant
    _checking_files
fi

if [[ $status -eq 0 ]] ; then
    cat "${folder_run}"../05/info/statistic.txt > my_actual_statistic.txt
    rm -rf "${folder_run}"../05/info
    sudo  goaccess --enable-panel=STATUS_CODES \
    --enable-panel=STATUS_CODES --sort-panel=BY_VISITORS \
    --ignore-panel=GEO_LOCATION  --ignore-panel=KEYPHRASES \
    --ignore-panel=REQUESTS_STATIC --ignore-panel=REFERRING_SITES-f \
    "${folder_run}"../04/logs/*.log --log-format=COMBINED -o goaccess_report.html
    sudo chmod ugo+rwxs goaccess_report.html 


    goaccess --sort-panel=BY_VISITORS --ignore-panel=GEO_LOCATION \
    --ignore-panel=KEYPHRASES --ignore-panel=REQUESTS_STATIC \
    --ignore-panel=REFERRING_SITES -a  --4xx-to-unique-count  -f "${folder_run}"../04/logs/*.log
fi
# END }
