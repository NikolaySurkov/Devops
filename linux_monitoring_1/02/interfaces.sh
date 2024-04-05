#!/bin/bash
SUM_I_FACE=""

define_the_interface() {
    SUM_I_FACE=$(ls "/sys/class/net"   -I "bon*" \
        -I "lo*" \
        -I "vir*" \
        -I "vnet*" \
        -I "macvtap*" \
        -I "br-*" \
        -I "docker*" | awk  'NR<=1 {printf $1}')
    if [ -z "$SUM_I_FACE" ]; then
        SUM_I_FACE="lo"
    fi
}

define_the_interface
echo $SUM_I_FACE
