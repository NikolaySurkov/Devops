#!/bin/bash
# reset_color="\033[0m"
# red_color="\e[0;91m"
# green_color="\e[1;93m"

str_name="${*}"

massiv_lat_letter=""
# max_length_str=7
# length_str=$(echo -n "$str_name" | wc -c)
status_add=0

number_token=$(echo "$@" | tr -d '[:upper:][:lower:]' | wc -c)
number_token=$((number_token -1))
max_token=$((7-number_token))

while [[ $status_add != 1 ]];
do
added_characters=""
 
read -p "enter no more than $max_token latin letters other than ${str_name}:" added_characters
            
strcheck=$(echo -n "$added_characters" | tr -d '[:upper:][:lower:]') 
check_str=$(echo -n "$added_characters" | tr -d "$str_name")

if [[  -z "$strcheck" ]] && [[ -n "$check_str" ]] && [[ ${#added_characters} -le $max_token ]];
then
    str_name+=$check_str
    massiv_lat_letter=""
    massiv_lat_letter=$(./create_massiv_str.sh "$str_name")
    status_add=1
fi
done

echo "${massiv_lat_letter[@]}"