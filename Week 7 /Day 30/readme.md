## Overview
We completed the script for exposing backend metrics to Prometheus and Grafana, created dashboards, and performed queries. We then worked on integrating an Angular frontend with the backend and configured Grafana for monitoring.

## Setup Instructions

### 1. Running the Master Script
Run the `master-script.sh` to create all required files and build the dashboard:
```sh
./master-script.sh
```

### 2. Setting Up Minikube
Run the `setup-wsl-minikube.sh` script to create the Minikube setup:
```sh
cd wsl-setup/
./setup-wsl-minikube.sh
```
If you encounter a Docker-related error, try running:
```sh
sudo dockerd
```
Then, rerun the script.

### 3. Setting Up Prometheus
```sh
cd prometheus
chmod +x setup-prometheus.sh
./setup-prometheus.sh
```

### 4. Setting Up Grafana
```sh
cd grafana
chmod +x setup-grafana.sh
./setup-grafana.sh
```

### 5. Configuring Angular App
We modified some key files in `angular-ui` (frontend):
- **`tsconfig.app.json`**
- **`tsconfig.json`**
- **`tsconfig.spec.json`**
- **`index.html`**
- **`main.ts`**
- **`nginx.config`**

### 6. Verifying Pods
Check if pods are running:
```sh
kubectl get pods -n sre-monitoring
```

### 7. Running the Setup Script
Run `setup.sh` to set up all files, build Docker images, and deploy them to Minikube:
```sh
./setup.sh
```
This script also applies Prometheus and Grafana configurations.

## Accessing the Application
Once setup is complete, access the application using the provided links. If the Angular UI is not accessible via Minikube IP, use port forwarding:
```sh
kubectl port-forward svc/angular-ui-service 8080:80 -n sre-monitoring
```

### Accessing Prometheus
- Navigate to the **Targets** section to verify data collection.

### Accessing Grafana
- Login Credentials:
  - **Username:** `admin`
  - **Password:** `admin`

## Creating Dashboards in Grafana
1. Create a new dashboard and add panels.
2. Set **Prometheus** as the data source.
3. Use the following queries for visualization:
   
   - **Gauge (Total HTTP Requests for `/api/alerts`)**
     ```
     http_requests_total{endpoint="/api/alerts"}
     ```
   - **Bar Chart (Total Requests for `/metrics`)**
     ```
     http_request_duration_seconds_count{endpoint="/metrics"}
     ```
   - **Histogram (CPU Time for Flask App)**
     ```
     process_cpu_seconds_total{job="flask-app"}
     ```
   - **Heatmap (CPU Utilization over 5 Minutes)**
     ```
     rate(process_cpu_seconds_total{job="flask-app"}[5m])
     ```

Save the dashboard as **SRE Dashboard for Angular**.

### Additional Queries in Prometheus
- **Real-time RAM usage:**
  ```
  process_resident_memory_bytes{job="flask-app"}
  ```
- **App Uptime:**
  ```
  time() - process_start_time_seconds{job="flask-app"}
  ```

## Conclusion
This setup ensures complete monitoring of the Angular application using Prometheus and Grafana. 🚀

