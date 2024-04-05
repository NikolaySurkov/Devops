#!/bin/bash

# comments

actual_date="_$(date +%D | awk -F'/' '{print $2$1$3}')"
path_to_object="$1"
first_num=$2
procent_random=$3
type_name="$4"
patterns_name=()
IFS=" " read -r -a patterns_name <<< "${5}"
number_token=$(echo -n "$5" | tr -d '[:upper:][:lower:]' | wc -c)
maxrandom=$((255 / number_token))

if [[ "$type_name" == "file" ]] ; then
    befor_point=$(echo "${patterns_name[@]}" | tr -d " "| awk -F "." '{print $1}')
    after_point=$(echo "${patterns_name[@]}" | tr -d " "| awk -F "." '{print $2}')
    length_name=${#befor_point}
    length_ex=${#after_point}
    number_token=$((length_name + length_ex+1))
    maxrandom=$((255 / number_token))
fi

actual_path="$path_to_object"
name_object=""
min_lenght_name=4
max_lenght_name=248
procent_random=$maxrandom

for letter_token in "${patterns_name[@]}" ; do
    rand=$((first_num + RANDOM % procent_random))
    i=0

    if [[ "$letter_token" == "." ]] ; then
        name_object+=$actual_date
        name_object+=$letter_token
        i=$rand
    fi

    while [ $i -lt $rand ] ; do
        name_object+=$letter_token
        i=$(( i + 1 ))
    done

done

if  [[ $(echo -n "${name_object%_*}" | wc -c) -lt $min_lenght_name ]] || [[ $(echo -n "${name_object%_*}" | wc -c) -gt $max_lenght_name  ]] ; then
    name_object=""
    actual_path=""
fi



if [[ $name_object != "" && "$type_name" == "folder" ]] ; then
    name_object+="$actual_date"
    actual_path+="$name_object/"
    dir_path=$(readlink -f "${actual_path}")
    if [[ -d "${dir_path}" ]] ; then 
        actual_path=""
    fi
elif [[ $name_object != "" && "$type_name" == "file" ]] ; then
    actual_path+="$name_object"
    dir_path=$(readlink -f "${actual_path}")
    if [[ -f "${dir_path}" ]] ; then 
        actual_path=""  
    fi
fi

echo -en "$actual_path"
