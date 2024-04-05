#!/bin/bash

## comment

declare path_rand
declare  memory_free_now

path_rand="$1"
memory_free_now=$(df -h "${path_rand:=/}" 2>/dev/null | awk '{printf("%s", $4)}' | sed -e 's/Avail//I' | tr -d 0-9. )

if [[ "$memory_free_now" !=  "G" ]]; then
    echo "There is little free memory left on the disk"
    df -h /  2>/dev/null
    exit 99
else 
    echo "OK"
fi