#!/bin/bash

# cd .. - чтобы запустить сборку из родительской папки и сделать доступной для COPY директорию part_3, 
#         в которой находятся си файл для минисервера, nginx.conf и скрипт компиляции исходного файла 
#         сервера | Альтернативой служит Makefile в родительской директории, запускающий скрипт

# docker build -f ./part_4/Dockerfile -t hello_world_server:part_4 . 
#        - создаем образ Docker из файла Dockerfile и «контекста».
#        -t  Имя репозитория(образа) будет  "hello_world_server", а тег — "part_4"

# docker run -dt -p 80:81 --name miniserver_part_4 hello_world_server:part_4
#        - создаем и запускаем новый контейнер "miniserver_part_4" из образа "hello_world_server:part_4"
#        можно добавить -v $(pwd)/part_3/nginx.conf:/etc/nginx/nginx.conf и удалить копирование nginx.conf из Dokerfile


# cd ..
echo ""
echo "Cобираем образ hello_world_server:part_4"
docker build -f Dockerfile_4 -t hello_world_server:part_4 .
echo ""
echo "Запускаем контейнер miniserver_part_4"
docker run -dt -p 80:81 --name miniserver_part_4 hello_world_server:part_4
echo ""
echo "===================================="
echo "=== Запущенные контейнеры Docker ==="
echo "===================================="
docker ps
echo ""
echo "====================="
echo "=== Docker образы ==="
echo "====================="
docker images
echo ""

# open -a "Google Chrome" http://localhost
# open -a "Google Chrome" http://localhost:80/status

# xdg-open http://localhost
# xdg-open http://localhost:80/status

