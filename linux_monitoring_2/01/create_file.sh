#!/bin/bash

absolut_path="$1"
massiv_tokens_for_name_file="$2"
type_random="$3"
number_files=${4:=5}
file_size="$5"
type_size="$6"

file_name=""
random_begin=1;
random_end=4
count_files=0
count_error=0


additional_recording_of_patterns() {
    befor_point=$(echo "${massiv_tokens_for_name_file}" | awk -F "." '{print $1}')
    after_point=$(echo "${massiv_tokens_for_name_file}" | awk -F "." '{print $2}')
    length_name=${#befor_point}
    length_ex=${#after_point}
    if [ "$length_name" -le "$length_ex" ];
    then
        massiv_tokens_for_name_file=$(./additional_recording_of_patterns.sh "${befor_point// /}")
        massiv_tokens_for_name_file+=". $after_point"
    else
        massiv_tokens_for_name_file="$befor_point"
        massiv_tokens_for_name_file+=". "
        massiv_tokens_for_name_file+=$(./additional_recording_of_patterns.sh "${after_point// /}" )
    fi
}


while [[ $count_files -lt $number_files ]] ; do
    count_error=0
    while [[ $file_name == "" ]] ; do
        file_name=$(./random_name.sh "$absolut_path" $random_begin $random_end "$type_random" "$massiv_tokens_for_name_file")
        count_error=$((count_error + 1))
        if [[  $count_error  -gt 350 ]] ; then
            additional_recording_of_patterns
            count_error=0
        else 
            random_end=$((random_end+1))
        fi
        count_error=$((count_error + 1))
    done
    count_files=$((count_files + 1))
    if fallocate -l  "$file_size$type_size" "$file_name" 2>/dev/null ; then
        echo -e "$file_name \t ${file_name##*/} \t $(stat -c %y "${file_name}") $(eval ls -lh "${file_name}"\
        | awk '{print $5}')">> log.txt
        file_name=""
    fi
    memory=$(./checking_memory_free.sh "${absolut_path}")
    if [[ "$memory" != "OK" ]] ; then
        echo "$memory"
        exit 9
    fi
done
echo "${massiv_tokens_for_name_file[@]}"
