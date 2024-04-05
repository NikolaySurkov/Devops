## Part 9. Bonus. Your own *node_exporter*

### Requirements: 
* ***linux ubuntu 20.04***
* ***installed Prometheus***
* ***installed Node Exporter***
* ***installed Grafana***
* ***installed Nginx***

### The script collects the basic metrics of the system (CPU, RAM, hard disk (capacity)).

* **Add to the prometheus file.yml the following lines.**

	![Ptometheus.yml](images_part_9/prometheus_yml_part.png)

* **Nginx.conf**

	![nginx.conf](images_part_9/nginx_conf.png)
	
* **This is an example of a generated html page**
	
	![html_my_exp_metric](images_part_9/metric_html.png)
	
* **Dashboards** 
	
	![grafana_dashboards_all](images_part_9/grafana_dashboards.png)
	
	* **CPU**
	
		![grafana_dashboards_cpu](images_part_9/grafana_cpu_loadagv.png)
		
	* **RAM**
	
		![grafana_dashboards_ram](images_part_9/grafana_ram.png)
		
	* **HARD DISK**
	
		![grafana_dashboards_hard_disk](images_part_9/grafana_hard_disk.png)
	
* **tests**

	![test_command_terminal](images_part_9/tests_part2_stress_terminal.png)
	
	* **test part 2 (hdd)**
	
		![grafana_dashboards_hdd](images_part_9/test_part_2_hdd_graf.png)
		
	* **stress test**
		![grafana_dashboards_cpu_ram](images_part_9/stress_test_cpu_ram_graf.png)
		

* **./main.sh** 
  * *Metrics are updated every 3 seconds.*(sleep 3) 
  * Almost all metrics are taken from the directory /proc
  *  	 */proc directory is not a real filesystem, it is a Virtual File System. It contains information about processes and other system information. It is mapped to /proc and mounted at boot time.*