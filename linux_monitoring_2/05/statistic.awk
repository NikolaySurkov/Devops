BEGIN {
    count_all=0
    count_error_4=0
    count_error_5=0
    count_success_2=0
    size_s=0
    size_error_4=0
    size_error_5=0
    size_all=0
}
{ 
    if($9~/^[4][0-9][0-9]$/) 
    {
        count_error_4++
        size_error_4+=$10
    } 
    else if ($9~/^[5][0-9][0-9]$/) 
    {
        count_error_5++
        size_error_5+=$10
    }
    
    else if($9~/^[2][0-9][0-9]$/) {
        count_success_2++
        size_s+=$10
    }

    if($9~/^[452][0-9][0-9]$/) {
        count_all++
        size_all+=$10
    }    
}
END {
    printf "%6d %6.2f MiB 4xx Client Errors\n", count_error_4, size_error_4/1048576
    printf "%6d %6.2f MiB 5xx Server Errors\n", count_error_5, size_error_5/1048576
    printf "%6d %6.2f MiB 2xx Success\n", count_success_2, size_s/1048576
    printf "%6d %6.2f MiB all\n", count_all, size_all/1048576
}