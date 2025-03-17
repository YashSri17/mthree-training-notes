# 📚 What is Toil? (SRE Concept)

**Toil** is any repetitive, manual, and automatable task that consumes engineering time without adding long-term value.

These tasks are essential for system upkeep but **do not contribute to permanent system improvement**.

---

## 🔍 Why Toil is Problematic

| Reason | Explanation |
|--------|-------------|
| 🕒 **Consumes Productive Time** | Engineers spend more time doing mundane tasks instead of building features or improving reliability. |
| 😩 **Demotivates Engineers** | Constant repetitive work kills motivation and creative thinking. |
| ❌ **Doesn’t Scale with Growth** | As systems grow, toil increases exponentially, but human effort doesn't. |
| 🚫 **No Long-Term Benefit** | Once toil is done, there's no residual value—the same task must be repeated. |
| 😓 **Delays Incident Response** | High toil leads to slower detection and resolution of incidents. |

> **Toil = Wasted Engineering Potential**

---

## ✅ Good vs. Bad Work: Toil vs Engineering

| Type | Description |
|------|-------------|
| ✅ **Engineering Work** | Builds features, creates automation, improves system resilience. |
| ❌ **Toil Work** | Restarting services, scanning logs manually, responding to non-actionable alerts. |

---

## 💣 Real-World Impact Example: Uber Scenario

Imagine you're managing infrastructure at Uber:

| Scenario | Impact |
|---------|--------|
| **100 users** | You can manually check logs and handle alerts. |
| **1 Million users** | Manual processes become unmanageable toil, blocking engineers from solving real problems. |

---

## 🛠️ How Toil Eats Your Production Time
40 hours/week (per engineer) ↓ 15–20 hours spent on repetitive log checking, alert filtering, RCA ↓ Only 50% time left for true engineering tasks ↓ Productivity drops, innovation stalls


---

## ✨ SRE Goal: Eliminate Toil

**Site Reliability Engineering (SRE)** practices focus on reducing toil:

- ✅ Automate everything repetitive
- ✅ Reduce human involvement in operations
- ✅ Build scalable solutions instead of doing manual work

---

> **"Toil is the tax you pay for not automating your operations. Your goal is to reduce it to zero."**

---
# 📈 Prometheus & Loki – Monitoring and Logging Tools (SRE Essentials)

## 📈 Prometheus – Metrics Monitoring Tool

### 🔍 What is Prometheus?
**Prometheus** is an open-source monitoring system that collects **metrics (numerical data)** from applications and infrastructure at regular intervals (e.g., CPU usage, memory, HTTP requests, etc.).

> It's the de facto tool in **Site Reliability Engineering (SRE)** for **time-series monitoring**.

### 💡 Prometheus Key Concepts

| Concept              | Description                                                                 |
|----------------------|------------------------------------------------------------------------------|
| 🔢 **Metric**         | Data point like `cpu_usage`, `http_requests_total`, `memory_free`.           |
| ⏱️ **Time-Series DB** | Stores metric data over time, like a graph.                                  |
| 📦 **Exporter**       | Agents that collect metrics from systems (e.g., Node Exporter for Linux).    |
| 🔍 **PromQL**         | Query language to extract and analyze data from Prometheus.                  |
| 📊 **Grafana**        | Visualization tool to plot Prometheus data (dashboards, graphs).             |

### 📦 Example Metrics

```
http_requests_total{job="frontend", status="200"} = 1250
node_cpu_seconds_total{mode="idle", cpu="0"} = 4572
```

### 🧠 Simple PromQL Query Examples

```promql
# Total HTTP requests
http_requests_total

# Requests per second (rate)
rate(http_requests_total[1m])

# CPU usage %
100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)
```

### 📄 Basic Prometheus Architecture

```
App / Server → Exporters → Prometheus → AlertManager → Grafana
```

### 📂 Common Exporters

| Exporter            | Purpose                                |
|---------------------|----------------------------------------|
| `node_exporter`     | Server/host metrics (CPU, memory, disk)|
| `blackbox_exporter` | Ping/HTTP uptime monitoring            |
| `cadvisor`          | Docker/container metrics               |
| `custom_exporter`   | Your own application metrics           |

## 📚 Loki – Log Aggregation Tool

### 🔍 What is Loki?
**Loki** is a **log aggregation system by Grafana Labs**, designed as a **Prometheus-style logging system for applications**.

- Collects and indexes **logs**
- Indexes **only metadata**, not full log content
- Designed to **scale and query logs efficiently**

### 🔗 Loki integrates best with:
- **Promtail** – Log shipper (similar to Fluentd or Filebeat)
- **Grafana** – Visualization and querying tool

### 🧩 Loki Stack Architecture

```
App → Promtail → Loki → Grafana
```

### 📄 Example Log (from Promtail)

```
2025-03-12T14:00:01Z INFO Starting service on port 8080
```

Promtail attaches **labels** like:

```yaml
job: backend
filename: /var/log/backend.log
level: INFO
```

In **Grafana**, you can query logs like:

```logql
{job="backend"} |= "ERROR"
```

### 💡 LogQL – Loki’s Query Language (PromQL-like for Logs)

| Example                  | Description                        |
|--------------------------|------------------------------------|
| `{job="app"}`            | Get logs from a specific job       |
| `|= "ERROR"`             | Filter logs containing "ERROR"     |
| `|~ "500|502"`           | Regex match for log content        |
| `| json | line.message`  | Parse structured JSON logs         |

## ✨ Prometheus vs Loki – Quick Recap

| Feature      | Prometheus             | Loki                          |
|--------------|------------------------|-------------------------------|
| **Data**     | Metrics (numerical)    | Logs (textual)                |
| **Query**    | PromQL                 | LogQL                         |
| **Collector**| Exporters              | Promtail                      |
| **Use case** | Performance/Health tracking | Root Cause Analysis & Debugging |

## 🚀 Example Use Case Workflow

```
1. Prometheus detects 5xx spike (HTTP error rate)
2. Alert triggered and sent to AlertManager
3. Engineer checks Grafana dashboard
4. Clicks on panel → jumps to Loki logs
5. LogQL query helps find root cause
6. Incident resolved → System improved
```

> **"Metrics tell you something's broken. Logs help you figure out why."**
