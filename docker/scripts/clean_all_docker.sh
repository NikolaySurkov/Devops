#!/bin/bash
## !! ВНИМАТЕЛЬНО, УДАЛЯЕТ ВСЕ !!
# docker stop $(docker ps -qa) остановка всех запущенных контейнеров
# docker rm $(docker ps -qa) удаление всех контейнеров
# docker rmi -f $(docker images -qa) удаление всех образов

# docker stop $(docker ps -qa) # остановка всех запущенных контейнеров
# docker rm $(docker ps -qa) # удаление всех контейнеров
# docker rmi -f $(docker images -qa) # удаление всех образов
# docker ps
# docker ps -a
# docker images


ACTIV_PROCESS=$(docker ps   --format '{{.Names}}' | grep -e "part_3" -e "miniserver_part_" -e "hello_world_miniserver" -e "nginx_x")
EXIT_PROCESS=$(docker ps  -a --format '{{.Names}}' | grep -e "part_3" -e "miniserver_part_" -e "hello_world_miniserver" -e "nginx_x" )
IMAGES_MY=$(docker images | grep -e  "hello_world_server"  -e "part" -e "nginx"  -e "latest" | awk '{printf "%s:%s\n",$1, $2}')
if [[ "$ACTIV_PROCESS" !=  "" ]]; then
        echo -e "Остановлены следующие контейнеры:"
        docker stop $ACTIV_PROCESS
fi

if [[ "$EXIT_PROCESS" !=  "" ]]; then
        echo -e "Удалены следующие контейнеры:"
        docker rm $EXIT_PROCESS
fi

if [[ "$IMAGES_MY" !=  "" ]]; then
        echo -e "Удалены следующие образы:"
        docker rmi $IMAGES_MY
fi

echo "====================="
echo "=== Docker образы ==="
echo "====================="
docker images 
echo "" 
echo "===================================="
echo "=== Запущенные контейнеры Docker ==="
echo "===================================="
docker ps 
echo "" 
echo "===================================="
echo "======= Все контейнеры Docker ======"
echo "===================================="
docker ps -a
echo "" 