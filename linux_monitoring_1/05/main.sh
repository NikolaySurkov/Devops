#!/bin/bash

time_start=$(date +%s.%N)
way_to_script=$(echo "$0" | sed 's/main.sh//')
chmod +x ${way_to_script}main.sh ${way_to_script}print_info.sh
way=$1

print_info() {
    ./print_info.sh $way
}

if [[ "$way" == "." ]];then
    way=$(pwd)
    way+="/"
fi

if [ $# -eq 1 ];
then
    if [[ "${way: -1}" = "/" ]]; then
        if [ ! -d "$1" ]; then
            echo "Directory "$way" DOES NOT exists."
        else
            print_info
            time_end=$(date +%s.%N)
            delta=$(bc<<<"scale = 2; $time_end - $time_start" )
            echo "$delta" | awk '{printf "Script execution time = %.2f sec.\n", $1}'
        fi
    else 
        echo "Incorrect input. There should be a \"/\" character at the end of the argument."
    fi
else 
    echo "Incorrect input of arguments"
fi

