#!/bin/bash
chmod +x main.sh create_file.sh print_conf.sh converter_color.sh help_to_file.sh checking.sh color.sh information.sh interfaces.sh
FILENAME="configuration"
FILE=$(find -iname "$FILENAME")
arguments_main=
ARG=
COLOR_ARG=
default_arg="6 2 6 4"
default_print="default default default default"

create_file() {
    if [[  -z "$FILE"  ]]; 
    then
        echo -n "The \"$FILENAME\" file does not exist, type to (Y) and press ENTER to create it...:">&2
        read answer
        if [ "$answer" = "Y" ] || [ "$answer" = "y" ]; then
        ./create_file.sh $FILENAME $default_arg
        FILE=$FILENAME
        fi
    fi
}

parser_arg() {
    if [[ ! -z "$FILE"  ]]; 
    then
        ARG1=$(cat configuration | grep -i -e 'column1_background' | head -1 | awk -F "=" '{printf  $2}')
        ARG2=$(cat configuration | grep -i -e 'column1_font*'      | head -1 | awk -F "=" '{printf  $2}')
        ARG3=$(cat configuration | grep -i -e 'column2_background' | head -1 | awk -F "=" '{printf  $2}')
        ARG4=$(cat configuration | grep -i -e 'column2_font*'      | head -1 | awk -F "=" '{printf  $2}')
        ARG1=$(echo $ARG1)
        ARG2=$(echo $ARG2)
        ARG3=$(echo $ARG3)
        ARG4=$(echo $ARG4)
        if [[ -z "$ARG1" ]] || [[ ${#ARG1} > 1 ]]; then
            ARG1="0"
        fi
        if [[ -z "$ARG2" ]] || [[ ${#ARG2} > 1 ]]; then
            ARG2="0"
        fi
        if [[ -z "$ARG3" ]] || [[ ${#ARG3} > 1 ]]; then
            ARG3="0"
        fi
        if [[ -z "$ARG4" ]] || [[ ${#ARG4} > 1 ]]; then
            ARG4="0"
        fi
        ARG=$(echo -E "$ARG1 $ARG2 $ARG3 $ARG4")
    fi
    ./checking.sh $ARG
}

color_arg() {
    ./color.sh $ARG
}

main_info() {
    ./information.sh $arguments_main
}

print_configuration() {
    ./print_conf.sh $default_print $arguments_main
}

convert_color() {
    ./converter_color.sh $ARG
}
if [ $# -eq 0 ];
then
    create_file
    parser_arg
    RES=$?
    if [ "$RES" -eq "0" ]; then
        arguments_main=$(color_arg)
        main_info
        arguments_main=$(convert_color)
        default_print=$(echo "$ARG1 $ARG2 $ARG3 $ARG4")
        print_configuration
    else 
        if [[ "$RES" -eq "22" || "$RES" -eq "32" ]]; 
        then
            ARG1=6
            ARG2=2
            default_print="default default "
            default_print+=$(echo "$ARG3 $ARG4")
            ARG=$(echo "$ARG1 $ARG2 $ARG3 $ARG4")
        elif  [[ "$RES" -eq "23" || "$RES" -eq "33" ]]; then
            ARG3=6
            ARG4=4
            default_print=$(echo "$ARG1 $ARG2")
            default_print+=" default default"
            ARG=$(echo "$ARG1 $ARG2 $ARG3 $ARG4")
        else
            ARG=$default_arg
        fi
        ./create_file.sh $FILENAME $ARG
        ./help_to_file.sh $FILENAME $RES
        arguments_main=$(color_arg)
        main_info
        arguments_main=$(convert_color)
        ARG=$default_print
        print_configuration
    fi
else 
    echo "There should be no arguments."
fi
