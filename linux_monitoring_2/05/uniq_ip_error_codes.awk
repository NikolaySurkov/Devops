BEGIN {
    count=0
}
{ 
    if($9~/^[45][0-9][0-9]$/) 
    {
        array_sort[$1]=$1
        count++
    } 
    
}
END {

    count=length(array_sort)
    for (key in  array_sort) {
         print key
    }
}