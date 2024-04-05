#!/bin/bash

info_interface() {
    ./interfaces.sh
}

ENDCOLOR="\e[0m"

INTERFACES=$(info_interface)
HOSTNAME=$(cat /proc/sys/kernel/hostname)
TIMEZONE=$(timedatectl | grep 'Time zone' | sed -e "s/^[[:space:]]*Time zone: //")
USER=$(id -run) #||(whoami)
OS=$(cat /etc/*-release | grep -e '^VERSION=' -e '^NAME' | awk -F "\"" '{printf $2 " "}')                                                              #and "$(uname -o)"
DATE=$(date)
UPTIME=$(uptime -p)
UPTIME_SEC=$( awk '{print $1}' /proc/uptime)
IP=$(ifconfig -a "${INTERFACES}" | grep 'netmask' | awk '{printf $2}')
MASK=$(ifconfig -a "${INTERFACES}" | grep 'netmask' | awk '{printf $4}')
GATEWAY=$(ip r | grep -e '^default via' | awk 'NR<=1 {print $3}')
RAM_TOTAL=$(free -m | grep -e 'Mem' |  awk '{printf "%.3f GB", $2/1024}')         #$(cat /proc/meminfo | grep -e 'MemTotal' | awk '{printf "%.3f Gb", $2/1024}')
RAM_USED=$(free -m | grep -e 'Mem' |  awk '{printf "%.3f GB", $3/1024}')
RAM_FREE=$(free -m | grep -e 'Mem' |  awk '{printf "%.3f GB", $4/1024}')
SPACE_ROOT=$(df / | awk '/\w\/\w/ {printf "%.2f Mb", $2/1024}')
SPACE_ROOT_USED=$(df /root | awk '/\w\/\w/ {printf "%.2f Mb", $3/1024}')
SPACE_ROOT_FREE=$(df /root | awk '/\w\/\w/ {printf "%.2f Mb", $4/1024}')

echo -e "${1}${2}HOSTNAME${ENDCOLOR} = ""${3}${4}$HOSTNAME${ENDCOLOR}" 
echo -e "${1}${2}TIMEZONE${ENDCOLOR} = ""${3}${4}$TIMEZONE${ENDCOLOR}"
echo -e "${1}${2}USER${ENDCOLOR} = ""${3}${4}$USER${ENDCOLOR}"
echo -e "${1}${2}OS${ENDCOLOR} = ""${3}${4}$OS${ENDCOLOR}"
echo -e "${1}${2}DATE${ENDCOLOR} = ""${3}${4}$DATE${ENDCOLOR}"
echo -e "${1}${2}UPTIME${ENDCOLOR} = ""${3}${4}$UPTIME${ENDCOLOR}"
echo -e "${1}${2}UPTIME_SEC${ENDCOLOR} = ""${3}${4}$UPTIME_SEC${ENDCOLOR}"
echo -e "${1}${2}IP${ENDCOLOR} = ""${3}${4}$IP${ENDCOLOR}"
echo -e "${1}${2}MASK${ENDCOLOR} = ""${3}${4}$MASK${ENDCOLOR}"
echo -e "${1}${2}GATEWAY${ENDCOLOR} = ""${3}${4}$GATEWAY${ENDCOLOR}"
echo -e "${1}${2}RAM_TOTAL${ENDCOLOR} = ""${3}${4}$RAM_TOTAL${ENDCOLOR}"
echo -e "${1}${2}RAM_USED${ENDCOLOR} = ""${3}${4}$RAM_USED${ENDCOLOR}"
echo -e "${1}${2}RAM_FREE${ENDCOLOR} = ""${3}${4}$RAM_FREE${ENDCOLOR}"
echo -e "${1}${2}SPACE_ROOT${ENDCOLOR} = ""${3}${4}$SPACE_ROOT${ENDCOLOR}"
echo -e "${1}${2}SPACE_ROOT_USED${ENDCOLOR} = ""${3}${4}$SPACE_ROOT_USED${ENDCOLOR}"
echo -e "${1}${2}SPACE_ROOT_FREE${ENDCOLOR} = ""${3}${4}$SPACE_ROOT_FREE${ENDCOLOR}"
