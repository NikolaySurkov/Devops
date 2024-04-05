#!/bin/bash

docker run --name part_3_container -d -p 81:81 nginx

docker ps

docker cp ./server/nginx.conf part_3_container:/etc/nginx/
docker cp ./server/hello_world_server.c part_3_container:/
docker cp ./part_3/hello_world_server.sh part_3_container:/home/
docker cp ./part_3/update_install.sh part_3_container:/home/
# docker exec -t -i part_3_container /bin/bash
docker exec part_3_container /home/update_install.sh
docker exec part_3_container /home/hello_world_server.sh