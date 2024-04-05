#!/bin/bash

info_interface() {
    ./interfaces.sh
}

INTERFACES=$(info_interface)
HOSTNAME=$(cat /proc/sys/kernel/hostname)
TIMEZONE=$(timedatectl | grep 'Time zone' | sed -e "s/^[[:space:]]*Time zone: //")
USER=$(id -run)||$(whoami)
OS=$(cat /etc/*-release | grep -e '^VERSION=' -e '^NAME' | awk -F "\"" '{printf $2 " "}')                                                              #and "$(uname -o)"
DATE=$(date)
UPTIME=$(uptime -p)
UPTIME_SEC=$( awk '{print $1}' /proc/uptime)
IP=$(ifconfig -a "${INTERFACES}" | grep 'netmask' | awk '{printf $2}')
MASK=$(ifconfig -a "${INTERFACES}" | grep 'netmask' | awk '{printf $4}')
GATEWAY=$(ip r | grep -e '^default via' | awk 'NR<=1 {print $3}')
RAM_TOTAL=$(free -m | grep -e 'Mem' |  awk '{printf "%.3f GB", $2/1024}')||(cat /proc/meminfo | grep -e 'MemTotal' | awk '{printf "%.3f Gb", $2/1024}')
RAM_USED=$(free -m | grep -e 'Mem' |  awk '{printf "%.3f GB", $3/1024}')
RAM_FREE=$(free -m | grep -e 'Mem' |  awk '{printf "%.3f GB", $4/1024}')
SPACE_ROOT=$(df / | awk '/\w\/\w/ {printf "%.2f Mb", $2/1024}')
SPACE_ROOT_USED=$(df / | awk '/\w\/\w/ {printf "%.2f Mb", $3/1024}')
SPACE_ROOT_FREE=$(df / | awk '/\w\/\w/ {printf "%.2f Mb", $4/1024}')

echo "HOSTNAME = "$HOSTNAME 
echo "TIMEZONE = "$TIMEZONE
echo "USER = "$USER
echo "OS = "$OS
echo "DATE = "$DATE
echo "UPTIME = "$UPTIME
echo "UPTIME_SEC = "$UPTIME_SEC
echo "IP = "$IP
echo "MASK = "$MASK
echo "GATEWAY = "$GATEWAY
echo "RAM_TOTAL = "$RAM_TOTAL
echo "RAM_USED = "$RAM_USED
echo "RAM_FREE = "$RAM_FREE
echo "SPACE_ROOT = "$SPACE_ROOT
echo "SPACE_ROOT_USED = "$SPACE_ROOT_USED
echo "SPACE_ROOT_FREE = "$SPACE_ROOT_FREE