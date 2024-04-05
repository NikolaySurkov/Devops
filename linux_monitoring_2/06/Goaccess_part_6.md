# Part 6

##Goaccess

GoAccess is an open source real-time web log analyzer and interactive viewer

* **goaccess [filename] [options...] [-c][-M][-H][-q][-d][...]**

> The screenshot shows the result of executing the script from the fifth part of the project. Folders whose names match the argument entered when running the script. The **`statistic.txt`** file displays information on each *log* separately and and general information about *all logs*.


![screenshot](images/my_statistic_logs.png)

### Terminal Output:

>   goaccess --sort-panel=BY_VISITORS --ignore-panel=GEO_LOCATION 
    --ignore-panel=KEYPHRASES --ignore-panel=REQUESTS_STATIC 
    --ignore-panel=REFERRING_SITES -a  --4xx-to-unique-count  -f ../04/logs/*.log
    

    
![screenshot](images/02_run_goaccess.png)

![screenshot](images/01_unique_visitors.png)
![screenshot](images/02_request_files_urls.png)
![screenshot](images/04_not_found_urls.png)
![screenshot](images/05_visitors_hostmame_ips.png)
![screenshot](images/06_operating_system.png)
![screenshot](images/07_browsers.png)
![screenshot](images/08_time_distribution.png)
![screenshot](images/10_13_referrers_url_status_codes.png)

### HTML Output 

>    sudo  goaccess --enable-panel=STATUS\_CODES 
    --enable-panel=STATUS\_CODES --sort-panel=BY_VISITORS 
    --ignore-panel=GEO\_LOCATION  --ignore-panel=KEYPHRASES 
    --ignore-panel=REQUESTS\_STATIC --ignore-panel=REFERRING\_SITES-f 
    ../04/logs/*.log --log-format=COMBINED -o goaccess\_report.html

![screenshot](images/001_b_unique_urls.png)
![screenshot](images/002_b_not_found_urls_visitor_ips.png)
![screenshot](images/003_operating_sys_browsers.png)
![screenshot](images/004_time_distrib_referrers_urls.png)
![screenshot](images/005_referring_sites_status_codes.png)
