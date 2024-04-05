# PART 7

### Installing  Prometheus on Ubuntu 20.04
* `sudo apt update`
* `sudo apt install prometheus`
* `sudo systemctl start prometheus`
* `sudo systemctl enable prometheus`
* `systemctl status prometheus`
* `http://localhost:9090`

	![prometheus_status.png](images_part_7/prometheus_status.png)

### Installing Grafana on Ubuntu 20.04

1. **Installing Grafana**
	* `wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -`
	* `sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"`
	* `sudo apt update`
	* `sudo apt install grafana`
	* `sudo systemctl enable grafana-server`
	* `sudo systemctl start grafana-server`
	* `sudo systemctl status grafana-server`
	
	**or**
	
	* `wget https://dl.grafana.com/oss/release/grafana_9.2.4_amd64.deb`
	`wget https://dl.grafana.com/oss/release/grafana_9.2.4_arm64.deb` *(APPLE M1 or M2)*
	* `sudo dpkg -i grafana_9.2.4_amd64.deb && \ sudo systemctl enable grafana-server && sudo systemctl 		start grafana-server`
	`sudo dpkg -i grafana_9.2.4_arm64.deb && \ sudo systemctl enable grafana-server && sudo systemctl start 		grafana-server`*(APPLE M1 or M2)*

	![grafana_status](images_part_7/grafana_status.png)



2. **`http://localhost:3000`**
	* 	`admin - admin`
	*  change password

### Dashboards

1. 
	* 	**CPU**
	
		![grafana_status](images_part_7/dashb_cpu.png)
	
	* 	**Free Space RAM**
	
		![grafana_status](images_part_7/dashb_free_space_ram.png)
		![grafana_status](images_part_7/dashb_free_space_all_used_ram.png)
	* **I/O Disk**

		![grafana_status](images_part_7/dashb_free_io_hard.png)
	
	* **Free and used hard disk space**

		![grafana_status](images_part_7/dashb_free_space_hard.png)
		![grafana_status](images_part_7/dashb_used_space_hard.png)

4. **Test PART_2**
		
	![grafana_status](images_part_7/run_part_2_free_code.png)
	![grafana_status](images_part_7/test_run_part_2_grafana.png)






5. **Stress test**

	![grafana_status](images_part_7/stress_test_code.png)
	![grafana_status](images_part_7/stress_test_cpu_ram_hard.png)


### Access the Prometheus and Grafana web interfaces from a local machine

* `ssh -fnNT -L 9090:127.0.01:9090 -L 3000:127.0.0.1:3000 username@ip`
* `port forwarding`