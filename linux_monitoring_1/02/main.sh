#!/bin/bash
chmod +x information.sh interfaces.sh main.sh 
rm  -f *.status

ARG=$#
RESET="\033[0m"
BOLD="\033[1m"
RED="\e[0;91m"
GREEN="\e[0;92m"

main_info() {
    ./information.sh
}

if [ $ARG -eq 0 ];
then
    main_info
    read -p "$(echo -e $GREEN"Do you want to write information to a file?$RED(Y/N): "$RESET)" answer
    if [ "$answer" = "Y" ] || [ "$answer" = "y" ]; then
        value=$(main_info)
        namefile="$(date +"%d_%m_%y_%H_%M_%S.status")"
        echo "$value" > $namefile
    fi
else
    echo "There should be no arguments"
fi
