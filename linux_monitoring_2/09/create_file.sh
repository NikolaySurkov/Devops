#!/bin/bash

# comments ...

folder_run="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/"

_print_nginx_file() {
    echo "events {"
    echo "}"
    echo "http {"
    echo "    server {"
    echo "        listen 8080;"
    echo "        server_name localhost;"
    echo "        root /usr/share/nginx/html/;"
    echo "        index index.html;"
    echo "        location /metrics {"
    echo "            default_type text/html;"
    echo "            alias $folder_run;"
    echo "            index metrics.html;"
    echo "        }"
    echo "	}"
    echo "}"
}

# MAIN() {
_print_nginx_file > nginx.conf
# }
