#!/bin/bash

#comments
path_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
chmod +x "$path_dir/main.sh"
source "$path_dir/create_file_log"
source "$path_dir/generate_ip_address"
source "$path_dir/dates_generator"
source "$path_dir/methods_generator"
source "$path_dir/response_code_generator"
source "$path_dir/agent_random"
source "$path_dir/generate_size"

declare  -i year
declare -i month
declare -i day
declare  date_rand
declare name_file_log
declare -i count_created_file_log
declare -i number_file_log
declare path_to_file_log
declare number_seconds_in_day
declare date_log_era
declare -i number_arg
number_arg=${#}


number_seconds_in_day=86400
path_to_file_log=""
number_file_log=5
count_created_file_log=0
date_log_era=""
name_file_log=""



_write_data_to_file() {
    number_entries_in_logfile=$(shuf -i 100-1000 -n 1)
    count_line=0
    max_time_plus=$((number_seconds_in_day/number_entries_in_logfile))
    while [[ $count_line -ne $number_entries_in_logfile ]] ; do
        time_plus=$(shuf -i 70-${max_time_plus} -n 1)
        date_log_era=$((date_log_era+time_plus))
        {
            _generate_ip
            echo -n " - - "
            _generate_date "${date_log_era}"
            _generate_metod 
            _generator_codes
            _generate_size
            _random_agent 
        } >>  "${path_to_file_log}"
        count_line=$((count_line+1))
    done
}

_random_date() {
    date_rand=19902323
    while ! date_log_era=$(date  +%s  -d "${date_rand}"  2>&1); do
        year=$(shuf -i 1990-2024 -n 1)
        month=$(shuf -i 1-12 -n 1)
        day=$(shuf -i 1-31 -n 1)
        date_rand="$year-$month-$day 00:00:00"
    done
    name_file_log="$(date +%Y_%m_%d -d "@${date_log_era}").log"
}

# MAIN() { BEGIN
if [[ $number_arg -eq 0 ]] ; then
    while [[ count_created_file_log -lt number_file_log  ]] ; do
        _random_date
        number_entries_in_logfile=$(shuf -i 100-1000 -n 1)
        time_plus=$((number_seconds_in_day/number_entries_in_logfile))
        path_to_file_log=$(_create_file_log "${name_file_log}")
        if [[ "${path_to_file_log}" != "ERROR" ]] ; then
            _write_data_to_file "${date_log_era}" 
            count_created_file_log=$((count_created_file_log+1))
        fi
    done
else
    echo "The script runs without arguments"
fi
# END }