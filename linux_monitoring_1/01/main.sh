#!/bin/bash
chmod +x main.sh
NUMBERS="^[-+]?[0-9]+\.?[0-9]*$"
ARG=$#

if [ $ARG -eq 0 ];
then
    echo "Specify one argument"
elif [ $ARG -gt 1 ];
  then
    echo "Specify only one argument"
elif [[  $1 =~ $NUMBERS ]];
  then 
    echo "Incorrect input of arguments"
else 
    echo "$1"
fi
