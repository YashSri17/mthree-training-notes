# ⚙️ Lightweight SRE Monitoring Setup with Minikube

The script file is attached with the name lightweight-sre-monitoring.sh 
This setup provides a quick and resource-efficient way to deploy a **Flask-based API**, instrumented with **Prometheus and Loki**, and monitored via **Grafana** on a **local Minikube cluster**.

---

## 📌 Prerequisites

Ensure the following tools are installed:

- `kubectl`
- `docker`
- `minikube`
- `helm`

---

## 🏗️ Setup Workflow Overview

1. Reset Minikube for a clean environment
2. Create a Python Flask API with SRE instrumentation (Prometheus metrics + logging)
3. Deploy to Kubernetes using YAML manifests
4. Setup lightweight monitoring using Helm:
   - Prometheus
   - Loki
   - Grafana
5. Load testing using a minimal script
6. Grafana dashboard creation instructions

---

## 🚀 Application Metrics Instrumentation (Flask + Prometheus)

| Metric | Description |
|--------|-------------|
| `app_request_count` | Counts HTTP requests (labeled by endpoint, method, status) |
| `app_request_latency_seconds` | Histogram of request latency (labeled by endpoint, method) |
| `app_error_count` | Counter for application errors (labeled by error type, endpoint) |
| `app_active_requests` | Gauge for active concurrent requests |

---

## 🔧 Kubernetes Deployment Summary

- **Namespace:** `sre-demo`
- **Components:**
  - `ConfigMap` for logging config
  - `Service` with Prometheus scrape annotations
  - `Deployment` with liveness and readiness probes

---

## 🩺 Health Probes

| Probe Type | Endpoint | Purpose |
|------------|----------|---------|
| Liveness Probe | `/health/liveness` | Checks if app is alive |
| Readiness Probe | `/health/readiness` | Checks if dependencies (e.g., DB) are ready |

---

## 📈 Monitoring Stack (Helm Install)

- **Namespace:** `monitoring`
- **Prometheus:** Minimal configuration (no Alertmanager, Pushgateway, NodeExporter)
- **Loki:** Lightweight logs storage
- **Grafana:** Visual dashboards with Prometheus + Loki datasources

---

## ⚡ Load Testing

- A basic script sends periodic requests to:
  - `/api/users`
  - `/api/error`
  - `/api/slow`
  - `/api/echo` (POST JSON)

---

## 📊 Grafana Dashboard Setup

### Prometheus Dashboards
- **Request Rate by Endpoint**: `sum(rate(app_request_count[1m])) by (endpoint)`
- **Error Rate (%)**: `sum(rate(app_request_count{http_status=~"5.."}[1m])) / sum(rate(app_request_count[1m])) * 100`
- **Latency (95th percentile)**: `histogram_quantile(0.95, sum(rate(app_request_latency_seconds_bucket[5m])) by (le, endpoint))`
- **Active Requests**: `app_active_requests`

### Loki Dashboards
- **Application Logs**: `{namespace="sre-demo"}`
- **Error Logs**: `{namespace="sre-demo"} |= "error"`
- **Log Volume**: `sum(count_over_time({namespace="sre-demo"}[1m]))`

---

## 🔐 Grafana Access
- **URL:** http://localhost:3000
- **Username:** `admin`
- **Password:** `admin`
- **Port Forward:** `kubectl port-forward svc/grafana 3000:80 -n monitoring`

---

## 🧼 Cleanup Commands
```bash
kill $(cat load-test.pid)
kill $(cat grafana.pid)
kubectl delete namespace sre-demo
kubectl delete namespace monitoring
minikube stop

