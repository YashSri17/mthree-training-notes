# 📊 Observability & Monitoring Notes

---

## 🔍 Key Metrics Explained (Restaurant Analogy)

| Metric     | Real-World Analogy                               | In Our Script (Prometheus Metrics)                             |
|------------|--------------------------------------------------|----------------------------------------------------------------|
| **Latency**   | Time from food order to delivery                 | `app_request_latency_seconds` – Measures time per request       |
| **Traffic**   | Number of customers entering per hour            | `app_request_count` – Counts incoming HTTP requests             |
| **Errors**    | Number of returned orders or customer complaints | HTTP error code tracking & explicit error counters (e.g., 500)  |
| **Saturation**| How full the restaurant is (table occupancy)     | `app_active_requests` – Measures concurrent active requests     |

---

## ✈️ Observability Foundations (Airplane Analogy)

| Concept         | Real-World Analogy                     | In Our Script                                              |
|------------------|----------------------------------------|-------------------------------------------------------------|
| **Metrics**         | Altitude, speed, fuel levels             | Prometheus collects system performance data (e.g., count, duration) |
| **Logs**            | Flight recorder (black box)              | Logs with timestamps and request IDs, collected via Loki     |
| **Visualization**   | Cockpit dashboard                        | Visual dashboards in Grafana                                 |
| **Instrumentation** | Sensors on aircraft parts                | Embedded metrics/logs in application code                    |

---

## 🩺 Health Monitoring (Doctor Analogy)

| Probe Type        | Real-World Analogy                  | In Our Script                                         |
|--------------------|-------------------------------------|--------------------------------------------------------|
| **Liveness Probe**   | Is the patient alive (pulse check)   | `/health/liveness` – App running check                |
| **Readiness Probe**  | Can the patient perform tasks?       | `/health/readiness` – App ready to serve traffic      |
| **Health Endpoints** | Medical tests (BP, temp, etc.)       | Multiple endpoints to monitor system health           |
| **Dependency Checks**| Are all organs working together?     | Check database connection before app readiness        |

---

## 📈 Service Level Objectives (SLOs) – Pizza Delivery Analogy

| SLO Component        | Real-World Analogy                  | In Our Script                                           |
|------------------------|-------------------------------------|----------------------------------------------------------|
| **Error Rate Tracking**   | Wrong pizza deliveries               | Track HTTP request errors                                 |
| **Latency Histograms**    | Delivery time across orders          | Use histograms (buckets) to analyze latency patterns      |
| **Request Success Rate**  | Percentage of correct deliveries     | Measure percentage of successful (non-error) requests     |

> **Example SLO:**  
"95% of pizzas delivered within 30 minutes"  
→ "99.9% of requests complete successfully in under 500ms"

---

## 📘 Normal Notes (Without Analogies)

### 🔍 Key Metrics in Monitoring
- **Latency**: Measures time taken to process each request (`app_request_latency_seconds`).
- **Traffic**: Number of incoming HTTP requests (`app_request_count`).
- **Errors**: Tracks request failures or HTTP error codes.
- **Saturation**: Shows current load/concurrency (`app_active_requests`).

### ✈️ Observability Foundations
- **Metrics**: Numerical system data via Prometheus.
- **Logs**: System activity records via Loki.
- **Visualization**: Graphs and dashboards via Grafana.
- **Instrumentation**: Code-level metrics and logs for observability.

### 🩺 Health Monitoring
- **Liveness Probe**: Checks if app is running.
- **Readiness Probe**: Checks if app is ready to serve.
- **Health Endpoints**: Endpoint-based health checks.
- **Dependency Checks**: Verifies DB and external service health.

### 📈 Service Level Objectives (SLOs)
- **Error Rate**: How many requests fail.
- **Latency Histogram**: Distribution of request times.
- **Success Rate**: Percentage of successful requests.
- **SLO Definition**: Target reliability/latency goals (e.g., 99% < 500ms).

---
