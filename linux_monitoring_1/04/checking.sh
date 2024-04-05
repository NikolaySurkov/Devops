#!/bin/bash
STRCHECK=$(echo -n "$1$2$3$4" | tr -d 0-9) 
ARG=$#
FLAG1=0
FLAG2=0

if [ $ARG -eq 4 ];
then

# checking for additional characters
    if [[ ! -z "$STRCHECK" ]]; then
        STRCHECK=$(echo -n "$1$2" | tr -d 1-6)
        if [[ ! -z "$STRCHECK" ]]; then
                FLAG1=1
        fi
        STRCHECK=$(echo -n "$3$4" | tr -d 1-6)
        if [[ ! -z "$STRCHECK" ]] && [[ "$FLAG1" == "0" ]]; then
            FLAG2=1
        elif [[ ! -z "$STRCHECK" ]] && [[ "$FLAG1" == "1" ]]; then
            echo "1"
            exit 31               
        fi
    fi

# checking the correctness of the digital parameter input
    if  [[ "$FLAG1" == "0" ]]; then
        if [[ $1 -lt 1 || $1 -gt 6 ]] || [[ $2 -lt 1 || $2 -gt 6 ]]; then
            FLAG1=1
        fi
    fi
    if  [[ "$FLAG2" == "0" ]]; then
        if [[ $3 -lt 1 || $3 -gt 6 ]] || [[ $4 -lt 1 || $4 -gt 6 ]]; then
            if [[ "$FLAG1" == "0" ]]; then
                FLAG2=1
            elif [[ "$FLAG1" == "1" ]]; then
                exit 31
            fi 
        fi
    fi

# checking for matching background and text color
    if [[ "$FLAG1" == "0" ]] && [[ "$1" -eq "$2" ]] && [[ "$3" -ne "$4" ]]; then
        FLAG1=1
    elif [[ "$FLAG1" == "0" ]]  && [ "$3" -eq "$4" ] &&  [ "$1" -ne "$2" ]; then
        FLAG2=1
    elif [[ "$FLAG2" == "1" ]] && [[ "$FLAG1" == "1" ]]; then
        exit 21
    fi

# finish checking
    if [[ "$FLAG1" -eq "1" ]] && [[ "$FLAG2" -eq "1" ]]; then
        exit 21
    elif [[ "$FLAG1" -eq "1" ]] && [[ "$FLAG2" -eq "0" ]]; then
        exit 22
    elif [[ "$FLAG1" -eq "0" ]] && [[ "$FLAG2" -eq "1" ]]; then
        exit 23
    fi
else 
    exit 1
fi   

exit 0