#!/bin/bash
directiry="$1"
print_base() {
    echo -n "Total number of folders (including all nested ones) = "
    find "$directiry" -type d  2>/dev/null | wc -l | sed 's/$/-1\n/' | bc
    echo  "TOP 5 folders of maximum size arranged in descending order (path and size):"
    du "$directiry" -hP 2>/dev/null | sort -h -r | head -5 | awk '{printf "%3d - %s, %s\n", NR, $2, $1}'
    echo -n "Total number of files = "
    ls -laR "$directiry" 2>/dev/null | grep "^-" | wc -l
    echo "Number of:"
    echo -n "Configuration files (with the .conf extension) = "
    find "$directiry" -type f -name "*.conf" 2>/dev/null| wc -l
    echo -n "Text files = "
    find "$directiry" -type f 2>/dev/null -exec file {} \; | awk '{printf "%s %s %s %s %s %s %s\n", $2, $3, $4, $5, $6, $7, $8}' | grep -e  'ASCII text' -e 'Unicode text' | wc -l
    # find $1 -type f -name "*.txt" | wc -l
    echo -n "Executable files = "
    find "$directiry" -type f -perm /u=x,g=x,o=x 2>/dev/null | wc -l
    echo -n "Log files (with the extension .log) = "
    find "$directiry" -type f -name "*.log" 2>/dev/null |  wc -l
    echo -n "Archive files = "
    find "$directiry" -type f 2>/dev/null -exec file {} \; | awk '{printf $3" "$4"\n"}' | grep -e  'compressed data' | wc -l
    # find $1 -type f -name "*.zip" -o -name "*.xz" -o -name "*.7z" -o -name "*.rar" -o -name "*.tar" | wc -l
    echo -n "Symbolic links = "
    find "$directiry" -type l 2>/dev/null | wc -l
}

TOP10_FILE_NAME_ALL=$(find "$1" -type f 2>/dev/null -exec du -h {} + | sort -hr | head -10 | awk '{printf "%s", $2"\t\n"}'| sed 's/ /_/g')
TOP10_FILE_SIZE_ALL=$(find "$1" -type f 2>/dev/null -exec du -h {} + | sort -hr | head -10 | awk '{printf "%s\t", $1}')
print_top10_all() {
    TOP10_FILE_NAME_ALL=($TOP10_FILE_NAME_ALL)
    TOP10_FILE_SIZE_ALL=($TOP10_FILE_SIZE_ALL)
    echo -e "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    if [[  -z "$TOP10_FILE_NAME_ALL" ]]; then
        echo "  There are no files."
    fi
    i=0;
    while [[ ("${TOP10_FILE_NAME_ALL[$i]}" != '') ]]
    do
        printf "%3d - " "$((i + 1))"
        echo -n "${TOP10_FILE_NAME_ALL[$i]},  "
        echo -n "${TOP10_FILE_SIZE_ALL[$i]},  "
        TOP10_FILE_TYPE_ALL=$(echo "${TOP10_FILE_NAME_ALL[$i]}" | sed 's/.*\///' | grep -oE "(^[^.]*$|(\.[^0-9])*(\.[^0-9]*$))")
        TOP10_FILE_TYPE_ALL=$(echo "$TOP10_FILE_TYPE_ALL" | sed 's/^[^.]*$//' | sed 's/\.//')
        echo "$TOP10_FILE_TYPE_ALL"
        ((i+=1))
    done

}

TOP10_NAME_FILE_EXEC=$(find "$1" -type f -executable 2>/dev/null -exec du -h {} + | sort -hr | head -10 | awk '{printf "%s\t", $2}'| sed 's/ /_/g')
TOP10_SIZE_FILE_EXEC=$(find "$1" -type f -executable 2>/dev/null -exec du -h {} + | sort -hr | head -10 | awk '{printf "%s\t", $1}')
print_top10_exec() {
    TOP10_NAME_FILE_EXEC=($TOP10_NAME_FILE_EXEC)
    TOP10_SIZE_FILE_EXEC=($TOP10_SIZE_FILE_EXEC)
    i=0
    echo -e "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
    if [[  -z "$TOP10_SIZE_FILE_EXEC" ]]; then
        echo "  There are no executable files."
    fi
    while [[ ("${TOP10_NAME_FILE_EXEC[$i]}" != '') ]]
    do
        printf "%3d - " "$((i + 1))"
        echo -n "${TOP10_NAME_FILE_EXEC[$i]},  "
        echo -n "${TOP10_SIZE_FILE_EXEC[$i]},  "
        TOP10_HASH_FILE_EXEC=$(md5sum "${TOP10_NAME_FILE_EXEC[$i]}" 2>/dev/null | awk '{print $1}')
        echo "$TOP10_HASH_FILE_EXEC"
        ((i+=1))
    done
}

print_base
print_top10_all
print_top10_exec