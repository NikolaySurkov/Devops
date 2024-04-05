#!/bin/bash
SED="sed -e 's/_/ /g' -e  's/column/Column /g' -e 's/=/ = /g' "

PRINT=""
BEFOR_ARG=($1 $2 $3 $4)
AFTER_ARG=($5 $6 $7 $8)
count=0
file="configuration"


for str in $( cat $file | grep -e '^column[1-2]_*' | head -4 | sed 's/ //g'  );
do
    PRINT+="\n$(echo $str | eval $SED | awk -F "=" '{printf $1 " = "}')"
    PRINT+="${BEFOR_ARG[count]}\t(${AFTER_ARG[count]})"
    ((count+=1))
done

echo -e $PRINT 
