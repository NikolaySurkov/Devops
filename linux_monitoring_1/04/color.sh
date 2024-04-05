#!/bin/bash

#  text color 
WHITE="\033[37m"
RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
PURPLE="\033[35m"
BLACK="\033[30m"

#  background color
BGWHITE="\033[47m"
BGRED="\033[41m"
BGGREEN="\033[42m"
BGBLUE="\033[44m"
BGPURPLE="\033[45m"
BGBLACK="\033[40m"

# variables 
color_argument=""
ARG="$#"
count=1

# writing colors to an argument string
for i in $@
do
    if [[ "$count" -eq 2 || "$count" -eq 4 ]];
    then
        if [ $i -eq 1 ];then
            color_argument+="$WHITE "
        elif [[ $i -eq 2 ]]; then
            color_argument+="$RED "
        elif [[ $i -eq 3 ]]; then
            color_argument+="$GREEN "
        elif [[ $i -eq 4 ]]; then
            color_argument+="$BLUE "
        elif [[ $i -eq 5 ]]; then
            color_argument+="$PURPLE " 
        elif [[ $i -eq 6 ]]; then
            color_argument+="$BLACK "
        else
            ARG=0
        fi
    elif [[ "$count" -eq 1 || "$count" -eq 3 ]];
    then
        if [ "$i" -eq 1 ];then
            color_argument+="$BGWHITE "
        elif [[ "$i" -eq 2 ]]; then
            color_argument+="$BGRED "
        elif [[ "$i" -eq 3 ]]; then
            color_argument+="$BGGREEN "
        elif [[ "$i" -eq 4 ]]; then
            color_argument+="$BGBLUE "
        elif [[ "$i" -eq 5 ]]; then
            color_argument+="$BGPURPLE " 
        elif [[ "$i" -eq 6 ]]; then
            color_argument+="$BGBLACK "
        else
            ARG=0
        fi
    fi
    (( count+=1 ))
done

# return
if [ $ARG -eq 4 ];
then
    echo -n $color_argument
else
    exit 1
fi
