#!/bin/bash

if [[  -f "$1"  && $2 > 0  ]];
then
    if [ "$2" -eq "21" ] ||  [ "$2" -eq "22" ] ||  [ "$2" -eq "23" ];
    then
        sed -i '1i # The background color and the text color should not match.  <---\n' $1
    else 
        sed -i '1i # Colour designations: \(1-white, 2-red, 3-green, 4-blue, 5-purple, 6-black\) <---\n' $1
    fi
else
    exit 0;
fi