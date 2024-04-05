#!/bin/bash
ARG=$#

for i in $@
do
    if [ $i -eq 1 ];then
        color_argument+="white "
    elif [ $i -eq 2 ]; then
        color_argument+="red "
    elif [[ $i -eq 3 ]]; then
        color_argument+="green "
    elif [[ $i -eq 4 ]]; then
        color_argument+="blue "
    elif [[ $i -eq 5 ]]; then
        color_argument+="purple " 
    elif [[ $i -eq 6 ]]; then
        color_argument+="black "
    else
        ARG=0
    fi
done

# return
if [ $ARG -eq 4 ];
then
    echo  -n $color_argument
else
    exit 1
fi