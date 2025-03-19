# Grafana Dashboard Setup Guide (Prometheus + Loki Integration)

## 🔧 Prerequisites
- Grafana installed and running (local or server)
- Prometheus installed and scraping metrics
- Loki setup for log aggregation
- Data sources accessible from Grafana

---

## 1️⃣ Start Grafana Server
- Start the Grafana server by running the monitoring script.
- Grafana UI will be accessible at: `http://localhost:3000`
- Login with default credentials:
  - **Username:** admin
  - **Password:** admin
- You will be welcomed by the Grafana dashboard interface.
![Grafana Dashboard Example](https://github.com/user-attachments/assets/d00fd18e-2355-4dbf-b707-a735724c1cfb)

---

## 2️⃣ Connect Prometheus to Grafana

### ➤ Steps:
1. Go to **⚙️ Configuration → Data Sources**
2. Click **Add data source**
3. Select **Prometheus**
4. In the **HTTP URL**, add:
   ```
   http://<PROMETHEUS_HOST>:<PORT>
   (e.g., http://localhost:9090)
   ```
5. Click **Save & Test**
   ![image](https://github.com/user-attachments/assets/7b75414b-83e2-41ca-b771-5e171fdacd22)


✅ Prometheus is now connected to Grafana.

---

## 3️⃣ Import a Dashboard via JSON

### ➤ Steps:
1. On the Grafana homepage, click **+ Create → Import**
2. Select your JSON file via:
   - Upload `.json` file
   - Paste JSON code
   - Import via Grafana.com Dashboard ID
3. If prompted, select a different **UID** to avoid conflicts.
4. Click **Import**
5. A dashboard will appear in front of you
6. Set the **data source to Prometheus**

✅ Your required dashboard is now available for use.
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%206/Day%2026/1g.jpeg)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%206/Day%2026/2g.jpeg)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%206/Day%2026/3g.jpeg)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%206/Day%2026/4g.jpeg)

---

## 4️⃣ Explore and Customize the Dashboard

### 🔹 View Metrics
- Look for all the available metrics on the dashboard.
- You can modify the **visualization types** (Graph, Stat, Gauge, etc.) for better representation.

### 🔹 Change Variables
- Dashboards often include template **variables** (e.g., `$instance`, `$job`)
- Modify these variables to dynamically change the view and filter data across panels.
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%206/Day%2026/6g.jpeg)
---

## 5️⃣ Connect Loki for Logs

### ➤ Steps:
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

## 6️⃣ Create Custom Panels with Metrics & Logs

### 🔹 **For Metrics (Prometheus) Panel:**
- Go to **+ Create → Dashboard → Add new panel**
- In the **Query section**, select **Prometheus** data source
- Write PromQL queries like:
  ```promql
  node_cpu_seconds_total{mode="idle"}
  rate(http_requests_total[5m])
  ```
- Choose appropriate visualization type

### 🔹 **For Logs (Loki) Panel:**
- Add a new panel and choose **Loki** as the data source
- Write LogQL queries like:
  ```logql
  {job="nginx"} |= "error"
  ```

---

## 7️⃣ Combine Logs and Metrics (Correlated View)
- Link panels using common labels (`instance`, `job`, etc.)
- Use the **Explore tab** to correlate metrics and logs interactively

---

## 8️⃣ Optional: Alerting (Using Prometheus or Loki)
- Navigate to **Alerting → Alert rules → Create alert rule**
- Define alerting thresholds and notifications

---

## 📁 Useful Tips
- Use **dashboard variables** for dynamic filtering
- Save dashboards as **JSON exports** for version control
- Use **templating & filters** for scalability

---




