# 📊 Grafana – Short Notes

## 🔍 What is Grafana?
Grafana is an **open-source visualization and analytics platform** that allows you to create **beautiful, interactive dashboards** using metrics from tools like **Prometheus, Loki, InfluxDB, Elasticsearch**, etc.

---

## 🌟 Key Features:
- Real-time monitoring dashboards
- Multiple data source integrations
- Alerting system
- Custom queries and visualizations
- User authentication and sharing

---

## 📂 Supported Data Sources:
- Prometheus
- Loki
- InfluxDB
- MySQL/PostgreSQL
- Elasticsearch
- AWS CloudWatch, Google Cloud, etc.

---

# 📈 Dashboard Creation in Grafana – Quick Steps

## 1️⃣ Add a Data Source
- Go to **Configuration → Data Sources → Add data source**
- Select **Prometheus**, **Loki**, etc.
- Enter server URL (`http://localhost:9090` for Prometheus)
- Click **Save & Test**

## 2️⃣ Create a Dashboard
- Click on **+ (Create)** → **Dashboard**
- Add a **New Panel**

## 3️⃣ Configure Panel
- Choose visualization type: **Graph, Gauge, Table, Bar chart, Stat, etc.**
- Write your **query**:
  - Example (Prometheus):  
    `rate(http_requests_total[1m])`
  - Example (Loki/LogQL):  
    `{job="backend"} |= "ERROR"`

## 4️⃣ Customize
- Set **Title, Axis, Units, Thresholds, Colors**
- Use **Transformations** or **Annotations** if needed

## 5️⃣ Save Dashboard
- Click **Save icon** → Give a name → Choose folder

---

# 🔔 Set Alerts (Optional)
- Inside a panel, go to **Alert → Create Alert**
- Set thresholds & conditions
- Choose notification channels (Email, Slack, Teams)

---

# 📥 Export/Import Dashboard
- **Export:** Share icon → Export JSON
- **Import:** + Create → Import → Upload JSON or paste ID from [Grafana.com Dashboards](https://grafana.com/grafana/dashboards)

---

# 📌 Pro Tips
- Use **variables** for dynamic dashboards (`$instance`, `$job`)
- Use **templating** for filtering
- Tag dashboards for better searchability

---

  # How we set up Grafana through ubuntu using just a single script
  # 🚀 Kubernetes Monitoring Stack with Prometheus, Loki, and Grafana

## 📌 Overview
This project sets up a lightweight Kubernetes monitoring stack using:

- **Prometheus** – For metrics monitoring
- **Loki + Promtail** – For log aggregation
- **Grafana** – For dashboards and visualization
- **Minikube** – Local Kubernetes cluster

---

# 🔍 Line-by-Line Explanation of `simple-grafana-monitoring.sh`

## 🐚 Bash Script Basics

```bash
#!/bin/bash
```
> Tells the system to run this script with the Bash shell.

```bash
set -e
```
> Exit the script immediately if any command fails (error-safe execution).

---

## 💻 Minikube Reset Section

```bash
read -p "Do you want to reset Minikube? (y/n): " reset_choice
```
> Asks user whether they want to start a fresh Minikube cluster or use the existing one.

```bash
if [[ "$reset_choice" == "y" ]]; then ...
```
> If "yes", deletes existing Minikube and starts a new cluster using Docker driver.

---

## ✅ Cluster Check

```bash
minikube status
kubectl get nodes
```
> Verifies that Minikube is running and Kubernetes node is active.

---

## 🔧 Deploying Sample Application

A `sample-logger` deployment is created in a namespace `sample-app`.  
The app continuously generates random `INFO`, `DEBUG`, and `ERROR` logs using BusyBox.

```yaml
args:
  - >
    while true; do
      echo "[INFO] Log entry at \$(date)";
      sleep 3;
      echo "[DEBUG] Processing data...";
      sleep 2;
      if [ \$((RANDOM % 10)) -eq 0 ]; then
        echo "[ERROR] Sample error occurred!";
      fi;
      sleep 1;
    done
```

🔸 This simulates real application logs for monitoring practice.

---

## 📈 Prometheus Installation

- Creates a fresh `monitoring` namespace.
- Adds Helm repos for Prometheus & Grafana.
- Installs Prometheus with a minimal config file (`prometheus-values.yaml`) — disables Alertmanager and Pushgateway for simplicity.

```yaml
server:
  persistentVolume:
    enabled: false
```

🔸 No persistent volume — ephemeral setup for testing only.

---

## 📡 Loki + Promtail Stack Installation

```bash
helm install loki grafana/loki-stack ...
```

- Loki = log storage and query engine  
- Promtail = log shipper that collects logs from Kubernetes pods  
- Grafana is disabled here because we install it separately.

---

## 📊 Grafana Installation

```yaml
datasources:
  datasources.yaml:
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus-server.monitoring.svc.cluster.local
    - name: Loki
      type: loki
      url: http://loki.monitoring.svc.cluster.local:3100
```

- Grafana is installed with pre-configured datasources (Prometheus + Loki).
- It also loads predefined dashboards automatically via URLs or Grafana IDs.

---

## ⏳ Wait & Port Forward Grafana

```bash
kubectl port-forward svc/grafana -n monitoring 3000:80 &
```

> Makes Grafana UI available locally on `http://localhost:3000`.

---

## 📋 Creating Custom Dashboard

Creates a custom dashboard (`dashboard.json`) with 2 panels:
- **All Logs Panel** from `sample-logger`
- **Filtered Error Logs Panel** from that app using LogQL

```json
"expr": "{namespace=\"sample-app\"} |= \"ERROR\""
```

---

## 📤 Uploading Dashboard to Grafana

```bash
curl -X POST -d @dashboard.json http://admin:admin@localhost:3000/api/dashboards/db
```
> Pushes the custom dashboard to Grafana using API.

---

## 📢 Final Setup Info

Prints access credentials:

```
Grafana: http://localhost:3000  
Username: admin  
Password: admin
```

---

## ⏳ Keeps Script Alive

```bash
wait $PORT_FORWARD_PID
```
> Keeps the port-forward alive until you manually stop it (Ctrl+C).

---

## 🔥 Summary of What This Script Does

| Task                  | Tool             |
|-----------------------|------------------|
| Kubernetes Setup      | Minikube         |
| Sample App Logs       | BusyBox          |
| Metrics Monitoring    | Prometheus       |
| Log Aggregation       | Loki + Promtail  |
| Visualization         | Grafana          |
| Dashboard Creation    | JSON + API upload |


## 📐 Architecture Diagram

```text
                ┌────────────────────┐
                │  Sample Logger App │
                │  (Busybox Pod)     │
                └────────┬───────────┘
                         │ Logs
                         ▼
                ┌────────────────────┐
                │     Promtail       │
                └────────┬───────────┘
                         │ Sends logs
                         ▼
┌──────────────┐   ┌────────────────────┐     ┌────────────────────┐
│  Prometheus  │<──│     Loki Stack     │<────│  Kubernetes Cluster │
│ (Scrapes metrics) │ (Stores logs)     │     │  (Minikube)         │
└──────────────┘   └────────────────────┘     └────────────────────┘
                         ▼                          ▲
                  ┌────────────┐     Queries        │
                  │  Grafana   │<───────────────────┘
                  │ Dashboards │
                  └────────────┘
```

---

## 🔧 Components & Tools

| Tool           | Purpose                                  |
|----------------|------------------------------------------|
| Prometheus     | Scrapes metrics from Kubernetes/Pods     |
| Loki           | Stores logs                              |
| Promtail       | Collects logs from pods and sends to Loki|
| Grafana        | Visualizes metrics and logs              |
| Helm           | Package manager for Kubernetes           |
| Minikube       | Local single-node Kubernetes cluster     |

---

## ⚙️ Setup Steps (Automated via Bash Script)

### ✅ Reset Minikube (optional)
- Stops and deletes previous cluster
- Starts new Minikube cluster with Docker driver

### ✅ Deploy Sample Logging App
- Creates a BusyBox-based logger pod that generates `INFO`, `DEBUG`, and `ERROR` logs

### ✅ Install Prometheus via Helm
- Minimal configuration
- No persistent storage for testing

### ✅ Install Loki Stack
- Promtail configured to collect logs from all namespaces

### ✅ Install Grafana
- Preconfigured datasources (Prometheus & Loki)
- Dashboards auto-imported (via JSON or Grafana dashboard URLs)

### ✅ Create and Import Custom Dashboard
- Creates a dashboard with:
  - Sample Logs Panel
  - Error Logs Panel (using LogQL query)
- Uploaded to Grafana using API

---

## 📊 Dashboard Panels (Default)

| Panel Title         | Data Source | Query / Description                          |
|---------------------|-------------|----------------------------------------------|
| Sample App Logs     | Loki        | `{namespace="sample-app", app="sample-logger"}` |
| Error Logs          | Loki        | `{namespace="sample-app"} |= "ERROR"`           |

---

## 🔐 Access Details

- Grafana UI: [http://localhost:3000](http://localhost:3000)
- Username: `admin`
- Password: `admin`

To access Kubernetes Dashboard:
```bash
minikube dashboard
```

---

## 📂 Directory Summary

| File                     | Purpose                                      |
|--------------------------|----------------------------------------------|
| `simple-grafana-monitoring.sh` | Main bash script to automate setup           |
| `prometheus-values.yaml`       | Custom values for Prometheus installation    |
| `grafana-values.yaml`          | Preconfigure datasources & dashboards        |
| `dashboard.json`               | Custom dashboard for application logs        |

---

## 📌 Credits
- Grafana Labs
- Prometheus Community Helm Charts
- Loki Stack Charts
- Kubernetes Community

---

> This setup is intended for local development, POCs, and monitoring practice. For production environments, ensure persistent volumes, secure credentials, and use alerting best practices.


