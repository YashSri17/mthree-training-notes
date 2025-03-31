# Accessing Prometheus and Creating Grafana Dashboard
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/31.png)
In my system the Angular UI is not accessible through minikue ip. So I
used port forwarding
kubectl port-forward svc/angular-ui-service 8080:80 -n sre-monitoring

# Targets in Prometheus
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/32.png)

![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/33.png)

# Accessing Grafana
Login credentials are also displayed in the ubuntu terminal
Username:admin
Password:admin
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/34.png)

# Next create the dashboard by clicking on create dashboard and then
adding a new panel and then going to perform the queries.
# Click on add visualization and select prometheus as data source then
select Gauge as visualization and performed the below query
http_requests_total{endpoint="/api/alerts"}


![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/35.png)

The query retrieves the total count of HTTP requests received for
/api/alerts.
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/36.png)

# Next click on add visualization and select prometheus as data source and
then select visualization as bar chart and then performed the below query
http_request_duration_seconds_count{endpoint="/metrics"}
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/37.png)

# Other Boards
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/38.png)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2031/39.png)
