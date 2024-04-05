#!/bin/bash 
# cd ./part_6/
echo "==================================="
echo "====   Сборка docker-compose   ===="
echo "==================================="
docker-compose build   
echo "====================="
echo "=== Docker образы ==="
echo "====================="
docker images 
echo "==================================="
echo "====   Запуск docker-compose   ===="
echo "==================================="
docker-compose up -d
echo "===================================="
echo "=== Запущенные контейнеры Docker ==="
echo "===================================="
docker ps 
echo "============================================"
echo "=== Запущенные контейнеры Docker-compose ==="
echo "============================================"
docker-compose ps -a  