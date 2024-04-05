#!/bin/bash
FILENAME="$1"
arg="$#"
rm -f $1
STR1="column1_background="
STR2="column1_font_color="
STR3="column2_background="
STR4="column2_font_color="

PAR1=$2
PAR2=$3
PAR3=$4
PAR4=$5

writing_template_to_file() {
    echo "$STR1$PAR1" >> "$FILENAME"
    echo "$STR2$PAR2" >> "$FILENAME"
    echo "$STR3$PAR3" >> "$FILENAME"
    echo "$STR4$PAR4" >> "$FILENAME"
}

create_file() {
    touch $FILENAME
}

if [ "$arg" -eq 0 ];
then
    read -p "$(echo "Enter the file name... : ")" FILENAME
fi

create_file
writing_template_to_file
