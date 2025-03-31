# Our Project Uber Monitoring Project - https://github.com/kiran-bsv/Mthree-T4-Project
# Uber Self-Healing App - Backend Deploment
Today we started with the deployment.yaml files to deploy our project on kubernetes. Below is the steps performed.

## Overview
The **Uber Self-Healing App** is designed to ensure high availability, fault tolerance, and automated recovery by integrating monitoring, logging, and Kubernetes-based self-healing mechanisms. This document outlines the key components and workflow of the system.


# Uber Project - Kubernetes Deployment

This guide walks you through the steps for deploying a Dockerized Uber project with Kubernetes, including setting up the frontend and backend services, securely managing database credentials using Kubernetes Secrets, and troubleshooting common issues.

---

## Prerequisites

- **Kubernetes Cluster** (Minikube or any other Kubernetes setup)
- **Docker** installed on your local machine
- **kubectl** installed for interacting with Kubernetes
- Docker Hub account (or other Docker image registry)

---

## Steps

### 1. Build Docker Images

#### Backend
To build the backend Docker image:

```bash
docker build -t your-dockerhub-username/uber-backend:latest ./backend
```

#### Frontend
To build the frontend Docker image:

```bash
docker build -t your-dockerhub-username/uber-frontend:latest ./frontend
```

### 2. Push Docker Images to Registry

Push the backend and frontend images to Docker Hub (or your private registry):

```bash
docker push your-dockerhub-username/uber-backend:latest
docker push your-dockerhub-username/uber-frontend:latest
```

#### If Using Minikube
If you are using Minikube, you can load the images directly into the Minikube environment:

```bash
minikube image load your-dockerhub-username/uber-backend:latest
minikube image load your-dockerhub-username/uber-frontend:latest
```

---

### 3. Create Kubernetes Secrets

Create a `secret.yaml` file to store sensitive information such as the database connection string.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: uber-db-secret
  namespace: uber
type: Opaque
data:
  DB_CONNECT: bW9uZ29kYjovL3ViZXItZGF0YWJhc2Utc2VydmljZToyNzAxNy91YmVyZGI=
```

Explanation:
- `DB_CONNECT` is your encoded database URL.
- Use `base64` to encode sensitive data.

To create the secret in Kubernetes:

```bash
kubectl apply -f secret.yaml
```

---

### 4. Kubernetes Deployment for Backend

Create a `deployment.yaml` file for the backend service.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
  namespace: uber
  labels:
    app: backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
        - name: backend
          image: your-dockerhub-username/uber-backend:latest
          ports:
            - containerPort: 5000
          env:
            - name: ENVIRONMENT
              value: "production"
            - name: LOG_LEVEL
              value: "INFO"
            - name: DB_CONNECT
              valueFrom:
                secretKeyRef:
                  name: uber-db-secret
                  key: DB_CONNECT
---
apiVersion: v1
kind: Service
metadata:
  name: backend-service
  namespace: uber
spec:
  selector:
    app: backend
  ports:
    - port: 5000
      targetPort: 5000
  type: ClusterIP
```

Apply the deployment:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

---

### 5. Kubernetes Deployment for Frontend

Create a `frontend-deployment.yaml` file for the frontend service.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  namespace: uber
  labels:
    app: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - name: frontend
          image: your-dockerhub-username/uber-frontend:latest
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
  namespace: uber
spec:
  selector:
    app: frontend
  ports:
    - port: 80
      targetPort: 80
  type: ClusterIP
```

Apply the frontend deployment:

```bash
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
```

---

### 6. Service Configuration

Both the frontend and backend are now running inside Kubernetes. The backend is exposed via the `backend-service`, and the frontend via the `frontend-service`.

To ensure the frontend connects to the backend service, use the backend's service name in the frontend code (e.g., `backend-service`).

---

### 7. Troubleshooting Image Pull Issues

If the pods are not starting and the image is not pulling, check the following:

#### Common Issues:
- **Incorrect Image Name**: Ensure that the image name in `deployment.yaml` is correct.
- **Image Not Pushed**: Verify that the image has been pushed to the registry.
- **Private Registry Issues**: Ensure Kubernetes can access your private registry by creating a Secret for authentication.

#### Debugging:
Run the following command to check pod status:

```bash
kubectl get pods
```

If the status is `ImagePullBackOff`, use:

```bash
kubectl describe pod <pod-name>
```

Check the **Events** section for detailed error messages about the image pull issue.

---

### 8. Accessing the Services

To access the services:

#### Access the Frontend:
Use the following command to get the ClusterIP or use Minikube to open the frontend:

```bash
minikube service frontend-service
```

#### Access the Backend:
Access the backend through the `backend-service` using its ClusterIP or IP.

---

## Conclusion

This guide helps us set up Kubernetes for your Uber Project, deploying Dockerized frontend and backend services. We've used Kubernetes Secrets to securely manage database credentials and successfully deployed both services with Kubernetes.

---


