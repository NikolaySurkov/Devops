#!/bin/bash
reset="\033[0m"
red="\e[0;91m"
green="\e[1;93m"

str_name_1="$*"
massiv_lat_letter=()
last_sym=""
count_sym=0
for letter in $(echo "${str_name_1}"| grep -o .)
do
    if [[ "$letter" != "${last_sym}"  &&  "${letter}" != " " ]];
    then 
        before=${#massiv_lat_letter[@]} 
        massiv_lat_letter[0]=$(echo -n "${massiv_lat_letter[@]}" | tr -d "${letter} ")
        after=${#massiv_lat_letter[@]} 
        if [ "$before" -eq "$after" ];
        then
            count_sym=$((count_sym + 1))
        fi
    fi

done
for letter in $(echo "${str_name_1}" | grep -o .)
do
    if [[ "${letter}" != "${last_sym}"  ]];
    then 
        massiv_lat_letter[count_sym]+="$letter "
        count_sym=$((count_sym + 1))
    fi
    last_sym="$letter"
done

# IF ONE letter  Needs improvement (works, but ugly) !!
if [[  ${#massiv_lat_letter[@]} == 1 ]] ; then

    read -p "$(echo -e "${green}""The name contains only one letter.\
    \nWith a large number of objects created, the file name can be very long.\
    \nYou can add $((7-${#massiv_lat_letter[@]})) more Latin letters for convenience.\
    \nShall we add?$red(Y/N): ""${reset}")" answer
    if [ "$answer" = "Y" ] || [ "$answer" = "y" ] ; then
        massiv_lat_letter[0]=$(./additional_recording_of_patterns.sh "${str_name_1}")
    fi
fi

echo "${massiv_lat_letter[@]}"
