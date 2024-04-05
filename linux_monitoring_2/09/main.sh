#!/bin/bash

# comments ...

_allow_execution() {
    chmod +x cpu_metric.sh create_file.sh hard_disk_space_metric.sh main.sh ram_metric.sh
}

_path_determinant() {
    folder_run="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/"
}

_install_nginx() {
    status_install="$(dpkg -l | grep nginx)"
    if [[ -z "$status_install" ]] ; then 
        sudo apt install -y nginx
    fi
}

_preparation_for_monitoring() {
    sudo systemctl restart  prometheus grafana-server.service 
    bash "${folder_run}create_file.sh"
    sudo cp "${folder_run}nginx.conf" /etc/nginx/nginx.conf 
    sudo nginx -t
    sudo service nginx restart
    sudo cp "${folder_run}prometheus.yml" /etc/prometheus/prometheus.yml
    sudo service prometheus restart
}

_run_monitoring() {
    while true ; do
        if [[ -f "${folder_run}metrics.html" ]] ; then
                rm -f "${folder_run}metrics.html"
        fi
        bash "${folder_run}ram_metric.sh" > "${folder_run}metrics.html"
        bash "${folder_run}cpu_metric.sh" >> "${folder_run}metrics.html"
        bash "${folder_run}hard_disk_space_metric.sh" >> "${folder_run}metrics.html"
		sleep 3;
	done
}


# MAIN {
if [[ $# -eq 0 ]] ; then
    _allow_execution
    _path_determinant
    _install_nginx
    _preparation_for_monitoring
    _run_monitoring
else
    echo -e "The script runs without parameters..."
fi
# }