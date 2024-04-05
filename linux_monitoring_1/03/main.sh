#!/bin/bash
chmod +x information.sh interfaces.sh main.sh checking.sh color.sh
arguments_main="$@"

checking_numbers() {
    ./checking.sh $arguments_main
}

color_arg() {
    ./color.sh $arguments_main
}

main_info() {
    ./information.sh $arguments_main
}


checking_numbers

if [ "$?" -eq 0 ]; then
    arguments_main=$(color_arg)
    main_info
fi
