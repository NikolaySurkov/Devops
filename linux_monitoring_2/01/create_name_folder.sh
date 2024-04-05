#!/bin/bash

absolut_path="$1"
massiv_tokens_for_name_file="$2"
type_random="$3"
folder_name=""
random_begin=1
random_end=4
count_error=0

while [[ $folder_name == "" ]] ; do
    folder_name=$(./random_name.sh "$absolut_path" $random_begin $random_end "$type_random" "$massiv_tokens_for_name_file")

    count_error=$((count_error + 1))
    if [[  $count_error  -gt 7500 ]] ; then
        echo  "The number of valid names has been exhausted!"
        exit 255
    fi
done

echo "$folder_name"
