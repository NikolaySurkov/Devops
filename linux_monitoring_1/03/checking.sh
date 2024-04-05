#!/bin/bash
STRCHECK=$(echo -n "$1$2$3$4" | tr -d 0-9) 
ARG=$#

if [ $ARG -eq 4 ];
then
    for i in $@               
    do
        if [[ ! -z "$STRCHECK" ]]; then
            echo "Enter only numbers from 1 to 6"
            exit 4
        elif [[ $i -lt 1 || $i -gt 6 ]];then
            echo "ENTER numbers 1-6"
            exit 1
        fi
    done
    
    if [[ $1 -eq $2 || $3 -eq $4 ]]; then
        echo "The background and text colors match"
        exit 2
    fi
else 
    echo "Incorrect input of arguments"
    exit 1
fi   


 exit 0