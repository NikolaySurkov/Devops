#!/bin/bash

# comments

declare mask
declare token_mask_letters
declare token_mask_date
declare  string_mask
declare last_letter

mask="${*}"
token_mask_letters=$(awk -F "_| " '{print $1}'<<<"${mask}")
token_mask_date=$(awk -F "_| " '{print $2}'<<<"${mask}")
string_mask="^.*/"
last_letter="7"

for letter in $(echo "${token_mask_letters} "| grep -o .) ; do
    if [[ "$letter" != "$last_letter"  ]] ; then 
        string_mask+="[$letter]{1,}"
    fi
    last_letter="$letter"
done

string_mask+="_${token_mask_date}([.]{1}[a-zA-Z]{1,240}){0,1}"
echo "${string_mask}"
