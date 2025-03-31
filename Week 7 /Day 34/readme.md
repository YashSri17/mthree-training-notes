# Our Project Uber Monitoring Project - https://github.com/kiran-bsv/Mthree-T4-Project
# Uber Self-Healing App - Backend Deploment
Today we started with the deployment.yaml files to deploy our project on kubernetes. Below is the steps performed.

## Overview
The **Uber Self-Healing App** is designed to ensure high availability, fault tolerance, and automated recovery by integrating monitoring, logging, and Kubernetes-based self-healing mechanisms. This document outlines the key components and workflow of the system.

# Kubernetes Deployment for Uber Project

This guide explains how to deploy the Uber Backend and Frontend on Kubernetes, including connecting to a database, using Docker images, creating secrets, and troubleshooting common issues.

## Prerequisites
- Minikube installed
- Docker
- kubectl configured
- Docker images for frontend and backend built and pushed to Docker registry
- Kubernetes cluster setup (Minikube or otherwise)

## Steps for Kubernetes Deployment

### 1. Create Docker Images for Frontend and Backend
- Ensure you have Docker images for both frontend and backend.
- Build images for both using the following commands:
  ```bash
  docker build -t frontend:latest ./frontend
  docker build -t backend:latest ./backend
Push images to your registry if using a Docker Hub or a private registry:

bash
Copy
Edit
docker push your-dockerhub-username/frontend:latest
docker push your-dockerhub-username/backend:latest
2. Create Secrets for Database Connection
Create a secret.yaml file to store sensitive information, like your database connection string:

yaml
Copy
Edit
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
  namespace: uber
type: Opaque
data:
  DB_CONNECT: <base64-encoded-connection-string>
You can encode your connection string using the following:

bash
Copy
Edit
echo -n "your-connection-string" | base64
The encoded string is used in the secret.yaml file.

3. Create Deployment YAML Files
Backend Deployment (backend/deployment.yaml)
yaml
Copy
Edit
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
  namespace: uber
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
          image: your-dockerhub-username/backend:latest
          ports:
            - containerPort: 5000
          env:
            - name: DB_CONNECT
              valueFrom:
                secretKeyRef:
                  name: db-secret
                  key: DB_CONNECT
        imagePullSecrets:
          - name: your-registry-secret
Frontend Deployment (frontend/deployment.yaml)
yaml
Copy
Edit
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  namespace: uber
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
          image: your-dockerhub-username/frontend:latest
          ports:
            - containerPort: 80
4. Create Services
Backend Service (backend/service.yaml)
yaml
Copy
Edit
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
Frontend Service (frontend/service.yaml)
yaml
Copy
Edit
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
5. Apply the Kubernetes Manifests
Apply the secret, backend, and frontend manifests:

bash
Copy
Edit
kubectl apply -f secret.yaml
kubectl apply -f backend/deployment.yaml
kubectl apply -f frontend/deployment.yaml
6. Verify Deployments
Check the deployments to ensure they are created successfully:

bash
Copy
Edit
kubectl get deployments -n uber
Verify the pods:

bash
Copy
Edit
kubectl get pods -n uber
Check if services are running:

bash
Copy
Edit
kubectl get svc -n uber
7. Troubleshooting Common Issues
ImagePullBackOff Errors
Ensure your Docker image name is correct in the deployment.yaml.

If you're using a private registry, make sure you have the correct registry secret for pulling the image.

Incorrect Secret Configuration
Verify that your secret.yaml is created and applied correctly.

Ensure the environment variable references the correct secret key.

Database Connection Issues
Make sure the DB_CONNECT environment variable is correctly set in your backend deployment.

Verify the database URL and ensure the database is accessible.

Nginx/Ingress Errors
If you are using Nginx Ingress and get a path conflict, ensure you are not duplicating paths in your ingress rules.

Check ingress rules using:

bash
Copy
Edit
kubectl get ingress -n uber
Logs and Debugging
Check logs for backend and frontend containers to diagnose issues:

bash
Copy
Edit
kubectl logs <pod-name> -n uber
Conclusion
With these steps, your Uber backend and frontend should be up and running on Kubernetes, with a secret management system for secure database connections. Always verify your environment variables and Docker images to avoid common deployment errors.

Feel free to reach out for further assistance with Kubernetes or Docker deployment.

vbnet
Copy
Edit

### Usage
- Replace placeholder values like `your-dockerhub-username` and `<base64-encoded-connection-string>` with actual values.
- If using a private registry, ensure you've created a `Secret` for authentication in Kubernetes.

