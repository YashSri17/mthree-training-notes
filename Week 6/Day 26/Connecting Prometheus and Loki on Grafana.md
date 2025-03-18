# Grafana Dashboard Setup Guide (Prometheus + Loki Integration)

## 🔧 Prerequisites
- Grafana installed and running (local or server)
- Prometheus installed and scraping metrics
- Loki setup for log aggregation
- Data sources accessible from Grafana

---

## 1⃣⃣ Connect Prometheus to Grafana

### ➔ Steps:
1. **Open Grafana UI** (default: `http://localhost:3000`)
2. **Login** (default: `admin/admin`)
3. Go to **⚙️ Configuration → Data Sources**
4. Click **Add data source**
5. Select **Prometheus**
6. In the **HTTP URL**, add:
   ```
   http://<PROMETHEUS_HOST>:<PORT>
   (e.g., http://localhost:9090)
   ```
7. Click **Save & Test**

✅ Now Prometheus is connected to Grafana.

---

## 2⃣⃣ Import a Dashboard via JSON

### ➔ Steps:
1. In Grafana, click the **+ (Create)** icon → **Import**
2. Options to import:
   - **Upload .json file**
   - **Paste JSON code**
   - **Import via Dashboard ID from Grafana.com**
3. Click **Load**
4. Select appropriate **data source** (e.g., Prometheus)
5. Click **Import**

✅ Your dashboard will now be visible with predefined panels.

---

## 3⃣⃣ Connect Loki for Logs

### ➔ Steps:
1. Go to **⚙️ Configuration → Data Sources**
2. Click **Add data source**
3. Select **Loki**
4. Provide the Loki URL:
   ```
   http://<LOKI_HOST>:<PORT>
   (e.g., http://localhost:3100)
   ```
5. Click **Save & Test**

✅ Loki is now integrated as a log data source.

---

## 4⃣⃣ Create Custom Panels with Metrics & Logs

### 🔹 **For Metrics (Prometheus) Panel:**
- Go to **+ Create → Dashboard → Add new panel**
- In **Query section**, select **Prometheus** data source
- Write PromQL queries like:
  ```promql
  node_cpu_seconds_total{mode="idle"}
  rate(http_requests_total[5m])
  ```
- Choose visualization type (Graph, Stat, Gauge, etc.)

### 🔹 **For Logs (Loki) Panel:**
- Add another panel → Choose **Loki** as data source
- Write LogQL queries like:
  ```logql
  {job="nginx"} |= "error"
  ```
- Use filters or regex for better analysis

---

## 5⃣⃣ Combine Logs and Metrics (Correlated View)

- You can **link panels** to show logs from a selected metric
- Use **Labels** (like `instance`, `job`) to correlate Prometheus and Loki data
- Enable **Explore** tab to deep dive into logs & metrics side-by-side

---

## 6⃣⃣ Optional: Alerting (Using Prometheus or Loki)

- Go to **Alerting → Alert rules → Create alert rule**
- Define **conditions**, **thresholds**, and **notification channels** (email, Slack, webhook)

---

## 📁 Useful Tips
- Use **dashboard variables** to create dynamic panels (e.g., `$instance`, `$job`)
- Save dashboards as **JSON exports** for reuse/version control
- Use **templating & filters** to manage large-scale observability dashboards

---

## 📂 Sample Directory Structure (Optional for Git Repos)
```
grafana-dashboard/
├── dashboards/
│   └── node_exporter_dashboard.json
├── prometheus/
│   └── prometheus.yml
├── loki/
│   └── config.yaml
├── README.md
```

---

