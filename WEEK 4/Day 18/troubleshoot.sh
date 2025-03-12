#!/bin/bash

NAMESPACE="k8s-demo"
APP_NAME="k8s-master-app"
NODE_PORT=30080

# Check if Kubernetes is running
echo "🔍 Checking if Kubernetes cluster is running..."
kubectl cluster-info >/dev/null 2>&1 || { echo "❌ Kubernetes cluster is not running!"; exit 1; }
echo "✅ Kubernetes cluster is running."

# Check if required files exist
echo "🔍 Verifying required files..."
FILES=("~/k8s-master-app/app/app.py" "~/k8s-master-app/app/requirements.txt" "~/k8s-master-app/app/Dockerfile")
for FILE in "${FILES[@]}"; do
    if [ ! -f $FILE ]; then
        echo "❌ Missing file: $FILE"
        exit 1
    fi
done
echo "✅ All required files are present."

# Check Docker image
echo "🔍 Checking if Docker image is built..."
minikube image ls | grep "$APP_NAME" >/dev/null 2>&1 || { echo "❌ Docker image not found! Rebuild using: minikube image build -t $APP_NAME:latest -f app/Dockerfile ."; exit 1; }
echo "✅ Docker image exists."

# Check pod status
echo "🔍 Checking pod status..."
kubectl get pods -n $NAMESPACE
POD_STATUS=$(kubectl get pods -n $NAMESPACE --no-headers | awk '{print $3}')
if [[ "$POD_STATUS" != "Running" ]]; then
    echo "❌ Pods are not running properly. Consider checking logs: kubectl logs -n $NAMESPACE -l app=$APP_NAME"
    exit 1
fi
echo "✅ Pods are running."

# Check service and port
echo "🔍 Checking service and port configuration..."
kubectl get svc -n $NAMESPACE | grep "$APP_NAME" >/dev/null 2>&1 || { echo "❌ Service not found! Apply service config: kubectl apply -f ~/k8s-master-app/k8s/base/service.yaml"; exit 1; }
echo "✅ Service exists."

PORT_CONFIG=$(kubectl get svc -n $NAMESPACE -o jsonpath='{.items[0].spec.ports[0].targetPort}')
if [[ "$PORT_CONFIG" != "5000" ]]; then
    echo "❌ Incorrect targetPort ($PORT_CONFIG), fixing..."
    sed -i 's/targetPort: .*/targetPort: 5000/' ~/k8s-master-app/k8s/base/service.yaml
    kubectl apply -f ~/k8s-master-app/k8s/base/service.yaml
    echo "✅ targetPort fixed and updated."
else
    echo "✅ Port configuration is correct."
fi

# Test application
APP_URL="http://$(minikube ip):$NODE_PORT"
echo "🔍 Testing application at $APP_URL..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)
if [[ "$HTTP_STATUS" != "200" ]]; then
    echo "❌ Application is not responding properly. Try port forwarding:"
    echo "   kubectl port-forward -n $NAMESPACE svc/$APP_NAME 5001:80 &"
    exit 1
fi
echo "✅ Application is accessible at $APP_URL."

echo "🚀 Troubleshooting completed successfully! Your Kubernetes app is deployed and running. 🎉"
