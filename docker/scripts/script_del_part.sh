#!/bin/bash
RUN_PART=""
IMAGES_PART=""
RED='\033[31m'
ENDCOLOR='\033[0m'
echo "                    ********************************"
echo "                     **  подготовка к запуску... **"
echo "                      *         PART $1           *"
echo "                       *  пожалуйста подождите  *"
echo "                        ************************"
ALL_PS=$(docker ps | tail -n+2 | awk '{printf "%s\n", $1}')
if [[ "$ALL_PS" !=  "" ]]; then
    docker stop   $ALL_PS
    # docker stop $(docker ps -qa)
fi


PORT_CLOSE=$(lsof -i :80 | grep LISTEN)
if [[ "$PORT_CLOSE" !=  "" ]]; then
    echo -e ${RED}"========================================================================================================="
    echo -e  "                   порт 80 занят другим процессом это может помешать запуску контейнера\n"
    echo -e $PORT_CLOSE
    echo -e "========================================================================================================="${ENDCOLOR}
    exit 1
fi
if [ "$1" ==  3 ]; then
    RUN_PART=$(docker ps | grep part_3_container)
    if [[ "$RUN_PART" !=  "" ]]; then
        docker stop miniserver_part_3
    fi
    RUN_PART=$(docker ps -a | grep part_3_container)
    if [[ "$RUN_PART" !=  "" ]]; then
        docker rm -f part_3_container
    fi
    IMAGES_PART=$(docker images | grep -o "nginx")
    if [[ "$IMAGES_PART" !=  "" ]]; then
        docker rmi -f nginx
    fi
elif [ "$1" ==  "4" ]; then
    RUN_PART=$(docker ps | grep miniserver_part_4)
    if [[ "$RUN_PART" !=  "" ]]; then
        docker stop miniserver_part_4
    fi
    RUN_PART=$(docker ps -a | grep miniserver_part_4)
    if [[ "$RUN_PART" !=  "" ]]; then
        docker rm -f miniserver_part_4
    fi
    IMAGES_PART=$(docker images | grep -o "hello_world_server   part_4")
    if [[ "$IMAGES_PART" !=  "" ]]; then
        docker rmi -f hello_world_server:part_4
    fi

elif  [[ "$1" -eq  "5" ]]; then
    RUN_PART=$(docker ps | grep miniserver_part_5)
    if [[ "$RUN_PART" !=  "" ]]; then
        docker stop miniserver_part_5
    fi
    RUN_PART=$(docker ps -a | grep miniserver_part_5)
    if [[ "$RUN_PART" !=  "" ]]; then
        docker rm -f miniserver_part_5
    fi
    IMAGES_PART=$(docker images | grep -o "hello_world_server   part_5")
    if [[ "$IMAGES_PART" !=  "" ]]; then
        docker rmi -f hello_world_server:part_5
    fi
elif  [[ "$1" -eq  "6" ]]; then
    RUN_PART=$(docker ps | grep -e "part_6-hello_world_miniserver-1" -e "part_6-nginx_x-1")
    if [[ "$RUN_PART" !=  "" ]]; then
        docker stop part_6-hello_world_miniserver-1
        docker stop part_6-nginx_x-1
    fi
    RUN_PART=$(docker ps -a | grep -e "part_6-hello_world_miniserver-1" -e "part_6-nginx_x-1")
    if [[ "$RUN_PART" !=  "" ]]; then
        docker rm -f part_6-hello_world_miniserver-1
        docker rm -f part_6-nginx_x-1
    fi
    IMAGES_PART=$(docker images | grep -o "hello_world_server   part_5")
    if [[ "$IMAGES_PART" !=  "" ]]; then
        docker rmi -f hello_world_server:part_5
    fi
fi

echo "               ======================================="
echo "               ========== все Docker образы =========="
echo "               ======================================="
docker images 

echo "               ======================================="
echo "               === все имеющиеся контейнеры Docker ==="
echo "               ======================================="
docker ps -a