#!/bin/bash

# comments

declare -a string_token
declare last_letter
declare -a array_token
declare -i count_element
array_token=()
last_letter="1"
string_token=("${@}")
count_element=0

for letter in $(echo "${string_token[*]} "| grep -o .) ; do
    if [[ "$letter" != "$last_letter"  ]] ; then 
        array_token[count_element]+="$letter "
        count_element=$((count_element + 1))
    fi
    last_letter="$letter"
done

echo "${array_token[@]}"
