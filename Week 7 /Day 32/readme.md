# Uber Self-Healing App - System Workflow - ER Diagram Creation
Today we started with creating ER Diagram of our project. below is the workflow.
## Overview
The **Uber Self-Healing App** is designed to ensure high availability, fault tolerance, and automated recovery by integrating monitoring, logging, and Kubernetes-based self-healing mechanisms. This document outlines the key components and workflow of the system.

---

## System Architecture
The architecture consists of three main components:
- **Application Layer** (Frontend & Backend)
- **Monitoring & Logging** (Prometheus, Loki, Grafana)
- **Self-Healing & Deployment** (Kubernetes, Docker, Heroku)

### **1. Application Layer**
#### Frontend (React App)
- Sends HTTP requests to the backend.
- Updates the UI based on real-time data.

#### Backend (Node.js API)
- Processes API requests.
- Handles ride bookings, user authentication, and business logic.
- Uses an **Event Listener** to manage ride requests.

#### Database
- Stores user, ride, and transaction data.

#### External Services
- **Payment Gateway** for handling transactions.
- **Mapping Services** for ride navigation and route optimization.

---

### **2. Monitoring & Logging**
#### Log Generation Script (Integrated with Uber Clone App)
- Generates synthetic logs to simulate different failure scenarios.

#### Prometheus
- Collects and processes metrics from backend services.
- Monitors API response times, error rates, and system performance.

#### Loki
- Processes and stores logs for real-time debugging.

#### Grafana
- Provides visual dashboards to monitor logs and metrics.
  
---

### **3. Self-Healing & Deployment Mechanism**
#### Kubernetes
- Manages containerized applications.
- Monitors pod health and performs self-healing actions such as:
  - **Triggering Scaling** when high traffic is detected.
  - **Restarting Containers** if failures occur.
  - **Replacing Unhealthy Instances** automatically.
  - **Adjusting Load Balancing** dynamically.

#### Heroku & Docker
- Deployment is handled via **Heroku**.
- Containers are managed using **Docker** to ensure consistency.

---

## Workflow Summary
1. **Frontend** sends user requests to the **backend API**.
2. The **backend** processes the request, interacts with external services, and updates the database.
3. Logs and metrics are generated and sent to **Loki** and **Prometheus**.
4. **Grafana** visualizes logs and metrics for monitoring.
5. If failures occur:
   - **Prometheus detects anomalies**.
   - Kubernetes triggers self-healing actions (e.g., restart pods, reschedule containers, scale resources).
   - The system continues running with minimal downtime.

---

## Future Enhancements
- Implement AI-driven anomaly detection for proactive issue resolution.
- Enhance logging with structured error reporting and root cause analysis.
- Improve autoscaling strategies based on predictive models.

---

## Conclusion
This architecture ensures a **highly available, fault-tolerant, and self-healing** Uber-like application by leveraging modern **cloud-native monitoring and automation tools**.

---

## 📜 ER Diagram
[!https://github.com/YashSri17/mthree-training-notes/blob/main/Week%207%20/Day%2032/ER%20Diagram.jpeg]
