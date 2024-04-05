#!/bin/bash

gcc hello_world_server.c  -o hello_world_server -lfcgi
spawn-fcgi -a  127.0.0.1 -p 8080 ./hello_world_server
nginx 


# service nginx start
# nginx -s reload
/bin/bash