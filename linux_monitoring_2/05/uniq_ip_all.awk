BEGIN {
    count=0
}
{ 
    array_sort[$1]=$1
}
END {
    count=length(array_sort)
    for (key in  array_sort) {
        print key
    }
}