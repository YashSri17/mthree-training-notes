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

  # How we set up Grafana through ubuntu using just a single script
  # 🚀 Kubernetes Monitoring Stack with Prometheus, Loki, and Grafana

## 📌 Overview
This project sets up a lightweight Kubernetes monitoring stack using:

- **Prometheus** – For metrics monitoring
- **Loki + Promtail** – For log aggregation
- **Grafana** – For dashboards and visualization
- **Minikube** – Local Kubernetes cluster

---

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


