## What is Mounting in Linux?

Mounting is the process of making a filesystem (like a USB drive, a network share, or even a Windows drive) accessible in a specific directory in Linux. It allows the operating system to recognize and interact with external storage or virtual filesystems.

Think of it like plugging in a USB drive: before you can use it, your system needs to "mount" it so that you can access its files.

## How Mounting Works in Linux

- **Physical or Virtual Storage Devices** (USB, HDD, SSD, network shares, etc.) must be mounted before they can be accessed.
- Once mounted, they appear as part of the Linux filesystem under a specific directory (called a **mount point**).
- The Linux filesystem does not use drive letters (`C:`, `D:`, etc.) like Windows. Instead, everything is part of a single hierarchical structure.

## Example: Mounting a Windows Drive in WSL (Windows Subsystem for Linux)

Since you're using Ubuntu in WSL, **Windows drives (C:, D:, etc.) are automatically mounted** under `/mnt/`.

- `C:\` in Windows becomes `/mnt/c/` in WSL.
- `D:\` in Windows becomes `/mnt/d/` in WSL.

So, when you access `/mnt/c/`, you're actually browsing your Windows `C:` drive **from within Linux**.

## Manually Mounting a Drive in Linux

If you need to manually mount a storage device, you can use:

```bash
sudo mount /dev/sdb1 /mnt/mydrive
```

- `/dev/sdb1` → The device (e.g., a USB drive or partition).
- `/mnt/mydrive` → The mount point where files will be accessible.

To unmount it:

```bash
sudo umount /mnt/mydrive
```

## Mounting a Directory (Bind Mount)

You can also mount a directory to another location using:

```bash
sudo mount --bind /mnt/c/kubernetes /home/user/k8s
```

Now, `/home/user/k8s` will show the same files as `/mnt/c/kubernetes`.

## Why is Mounting Important in Kubernetes?

- **Persistent Storage**: In Kubernetes, volumes are mounted into pods so they can store and share data.
- **HostPath Volumes**: Your script mounts `/mnt/c/kubernetes` into Kubernetes containers so they can read/write data from that folder.
- **WSL Integration**: Since WSL mounts Windows drives under `/mnt/`, it allows Linux processes to interact with Windows files.
# Kubernetes App Deployment Zero to Hero

## 📌 Overview
These are the steps to deploy your fixed Kubernetes application, including building the Docker image, configuring Kubernetes deployments and services, debugging issues, and testing the deployment that too just using a single script.

---

## ✅ Step 1: Build & Configure Docker Image

### 1️⃣ Navigate to the Project Directory
```bash
cd ~/k8s-master-app
```

### 2️⃣ Verify `app.py` and `requirements.txt` Location
Ensure that `app.py` and `requirements.txt` exist in `app/`:
```bash
find ~/k8s-master-app -name "app.py"
find ~/k8s-master-app -name "requirements.txt"
```
**Expected Output:**
```bash
/home/yashaswi_123/k8s-master-app/app/app.py
/home/yashaswi_123/k8s-master-app/app/requirements.txt
```

### 3️⃣ Check & Fix Dockerfile (Located in `app/`)

#### Open the Dockerfile:
```bash
nano ~/k8s-master-app/app/Dockerfile
```

#### Ensure it correctly copies app files and exposes port 5000:
```dockerfile
# Use Python 3.9
FROM python:3.9

WORKDIR /app

# Create necessary directories
RUN mkdir -p /data /config /logs && chmod 777 /data /config /logs

# Copy requirements file and install dependencies
COPY app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/app.py /app/app.py
RUN chmod +x /app/app.py

# Expose the application port
EXPOSE 5000

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Start the application
CMD ["python", "app.py"]
```
Save and exit (`CTRL + X`, then `Y`, then `Enter`).

### 4️⃣ Build the Docker Image for Kubernetes
```bash
minikube image build -t k8s-master-app:latest -f app/Dockerfile .
```
**Expected Output:**
```shell
#14 naming to docker.io/library/k8s-master-app:latest done
#14 DONE 0.7s
```

### 5️⃣ Verify the Docker Image is Built
```bash
minikube image ls | grep k8s-master-app
```
**Expected Output:**
```bash
k8s-master-app   latest
```

---

## ✅ Step 2: Deploy to Kubernetes

### 1️⃣ Apply Deployment Configuration
```bash
kubectl apply -f ~/k8s-master-app/k8s/base/deployment.yaml
```

### 2️⃣ Apply Service Configuration
```bash
kubectl apply -f ~/k8s-master-app/k8s/base/service.yaml
```

### 3️⃣ Check if Pods Are Running
```bash
kubectl get pods -n k8s-demo
```
**Expected Output:**
```sql
NAME                             READY   STATUS    RESTARTS   AGE
k8s-master-app-64f9d77599-xyz   1/1     Running   0          2m
```

---

## ✅ Step 3: Check & Fix Port Configuration

### 1️⃣ Verify the Kubernetes Service
```bash
kubectl get svc -n k8s-demo
```
**Expected Output:**
```pgsql
NAME             TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
k8s-master-app   NodePort   10.110.199.42    <none>        80:30080/TCP   45m
```

📌 If `targetPort` is incorrect, update `service.yaml`:
```bash
nano ~/k8s-master-app/k8s/base/service.yaml
```
Ensure it looks like this:
```yaml
spec:
  type: NodePort
  selector:
    app: k8s-master
  ports:
    - port: 80
      targetPort: 5000  # ✅ Ensure this matches `containerPort`
      nodePort: 30080
```
Save and apply changes:
```bash
kubectl apply -f ~/k8s-master-app/k8s/base/service.yaml
```

---

## ✅ Step 4: Restart the Deployment

To ensure all changes are applied correctly:
```bash
kubectl delete pod -n k8s-demo --all
kubectl get pods -n k8s-demo  # Wait for new pods to start
```

---

## ✅ Step 5: Test the Application

### 1️⃣ Test via NodePort
Open in browser:
```cpp
http://192.168.58.2:30080
```
or test using:
```bash
curl http://192.168.58.2:30080
```
**✅ If the application is working, you'll get a response.**

### 2️⃣ If NodePort Fails, Use Port Forwarding
Run:
```bash
kubectl port-forward -n k8s-demo svc/k8s-master-app 5001:80 &
```
Now, open:
```arduino
http://localhost:5001
```

### 3️⃣ If Still Not Working, Check Logs
```bash
kubectl logs -n k8s-demo -l app=k8s-master
```
Look for errors and fix accordingly.

---

## 🚀 Final Summary
✔ Built the Docker image using `minikube image build`
✔ Ensured correct file paths in Dockerfile (`app.py`, `requirements.txt`)
✔ Applied Kubernetes deployment & service YAML files
✔ Checked and fixed port issues (`targetPort: 5000`)
✔ Restarted pods and verified they are running
✔ Tested the application via NodePort & Port Forwarding

📌 **Now your application is successfully deployed and accessible!** 🚀

