TARGET     = report
OS := $(shell uname -s)


all : clean_all  $(TARGET)  

$(TARGET) : 
ifeq ($(OS),Darwin)
	open -a "Google Chrome" ./report_html/report.html
else
	xdg-open  report_html/report.html
endif

run_part_3:  
	@chmod +x  ./part_3/*.sh
	@bash ./scripts/script_del_part.sh 3
	@echo "========================================================================"
	@echo "======   подготовка к запуску завершена      |     старт  Part 3   ====="
	@echo "========================================================================"
	@echo ""
	@bash ./part_3/run_part_3.sh
	@echo ""
	@echo "========================================================================="
	@echo "=== нажмите на ссылку ниже, чтобы проверить работу минисервера Part 3 ==="
	@echo "========================================================================="
	@echo "http://localhost:81"
	@echo ""


run_part_4:  
	@chmod +x  ./part_4/*.sh
	@bash ./scripts/script_del_part.sh 4
	@echo "========================================================================"
	@echo "======   подготовка к запуску завершена      |     старт  Part 4   ====="
	@echo "========================================================================"
	@echo ""
	@bash ./part_4/run_part_4.sh
	@echo ""
	@echo "========================================================================"
	@echo "=== нажмите на эти ссылки, чтобы проверить работу минисервера Part 4 ==="
	@echo "========================================================================"
	@echo "http://localhost:80/status"
	@echo "http://localhost:80"
	@echo ""

run_part_5:  
	@chmod +x  ./part_5/*.sh
	@bash ./scripts/script_del_part.sh 5
	@echo "========================================================================"
	@echo "======   подготовка к запуску завершена      |     старт  Part 5   ====="
	@echo "========================================================================"
	@echo ""
	@bash ./part_5/run_part_5.sh
	@echo ""
	@echo "========================================================================"
	@echo "=== нажмите на эти ссылки, чтобы проверить работу минисервера Part 5 ==="
	@echo "========================================================================"
	@echo "http://localhost:80/status"
	@echo "http://localhost:80"
	@echo ""

run_part_6:  
	@bash ./scripts/script_del_part.sh 6
	@echo "========================================================================"
	@echo "======   подготовка к запуску завершена      |     старт  Part 6  ======"
	@echo "========================================================================"
	@echo ""
	@bash ./part_6/run.sh
	@echo ""
	@echo "========================================================================"
	@echo "=== нажмите на эти ссылки, чтобы проверить работу минисервера Part 6 ==="
	@echo "========================================================================"
	@echo "http://localhost:80/status"
	@echo "http://localhost:80"
	@echo ""

install_dockle: 
ifeq ($(OS),Darwin)
	brew install goodwithtech/r/dockle
	open -a "Google Chrome" https://github.com/goodwithtech/dockle
else
	xdg-open https://github.com/goodwithtech/dockle
endif 

install_docker-compose: 
ifeq ($(OS),Darwin)
	@docker-compose --version
else
	xdg-open https://docs.docker.com/compose/install/linux/
endif 

install_docker: 
ifeq ($(OS),Darwin)
	open -a "Google Chrome" https://docs.docker.com/desktop/install/mac-install/
else
	xdg-open https://docs.docker.com/desktop/install/linux-install/
endif 

clean_all:
	@bash ./scripts/clean_all_docker.sh