# React SRE Project

## Overview
This project involves deploying a React-based SRE (Site Reliability Engineering) monitoring system. It includes a backend built with Flask, a frontend React app, and a monitoring setup using Grafana and Prometheus.

---

## Revision and Initial Errors
- **Reviewed queries and dashboards** from previous sessions.
- **Ran the script** and encountered errors:
  - **WSL-related error**: Fixed by modifying the script with:
    ```sh
    if ! grep -qEi "(microsoft|wsl)" /proc/version
    ```
  - **Docker error**: Resolved by running:
    ```sh
    sudo dockerd
    ```
  - **NPM-related error**: Fixed by running:
    ```sh
    npm uninstall react react-dom
    npm install react@18 react-dom@18
    sudo apt update && sudo apt upgrade
    ```
  - Successfully **re-executed the script**:
    ```sh
    ./complete-react-sre-script.sh
    ```

---

## Deploying the React SRE Application
- Navigate to project directory:
  ```sh
  cd react-sre-project
  ```
- Run deployment script:
  ```sh
  ./deploy_sre_app.sh
  ```
- **Fixed errors**:
  - WSL check issue resolved using the script modification above.
  - Docker & Minikube issues resolved by checking Minikube status:
    ```sh
    minikube status
    ```
    and restarting Docker:
    ```sh
    sudo dockerd
    ```

---

## Backend Development and Exposing Metrics
- **Flask Backend API Endpoints**:
  - `/` - Main Route
  - `/api/health` - Health Check
  - `/api/metrics` - Prometheus Metrics
- Created files:
  - `Dockerfile`
  - `Deployment YAML`
  - `Service YAML`
  - `requirements.txt`
- Start Flask API:
  ```sh
  python3 health-api.py
  ```
- **Verify API Calls**:
  ```sh
  curl http://localhost:5000/api/metrics
  ```

---

## Frontend Deployment
- **Build Docker Image**:
  ```sh
  docker build --no-cache -t react-sre-app:latest .
  ```
- **Load Image into Minikube**:
  ```sh
  minikube image load react-sre-app:latest
  ```
- **Apply Kubernetes Configurations**:
  ```sh
  cd kubectl/overlays
  kubectl apply -k dev
  cd ../base
  kubectl apply -f deployment.yaml
  kubectl apply -f service.yaml
  ```
- **Start Frontend**:
  ```sh
  npm start
  ```

---

## Monitoring & Grafana Dashboard Setup
- **Ensure Minikube is running**:
  ```sh
  minikube status
  ```
- **Port-forward Grafana**:
  ```sh
  kubectl port-forward svc/grafana 8080:3000 -n monitoring
  ```
- **Create Grafana Dashboard**:
  - **Variables**:
    ```sh
    Name: service
    Label: service
    Type: query
    Datasource: prometheus
    Query: label_values(up, service)
    Sort: Alphabetical (asc)
    ```

### Grafana Panels
1. **Service Uptime**
   - **Visualization**: Stat
   - **Query**:
     ```sh
     up{service=~"$service"}
     ```
2. **Service Availability (SLO: 99.9%)**
   - **Visualization**: Gauge
   - **Query**:
     ```sh
     sum(rate(http_requests_total_count{service=~"$service", status!~"5.."}[30m]))
     / sum(rate(http_requests_total_count{service=~"$service"}[30m])) * 100
     ```
3. **Successful Requests in Prometheus**
   - **Visualization**: Gauge
   - **Query**:
     ```sh
     prometheus_http_requests_total{code="200"}
     ```
4. **Alertmanager Discovery Status**
   - **Visualization**: Table
   - **Query**:
     ```sh
     prometheus_notifications_alertmanagers_discovered{job="prometheus"}
     ```

---

## Final Steps
- **Completed Minikube setup**, backend & frontend deployment.
- Built & deployed Docker images.
- Created Grafana dashboard with key monitoring panels.
- **If port-forwarding fails**, ensure Minikube is running and retry:
  ```sh
  kubectl port-forward svc/grafana 8080:3000 -n monitoring
  ```
- Verified dashboard metrics and confirmed successful data collection.
---

## Project Screenshots

