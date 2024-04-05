{
    lines[NR] = $9"&"$0
}

# Process lines
END {
	asort(lines)
    for (i = 1; i <= NR; i++) {
        print lines[i]
    }
} 

