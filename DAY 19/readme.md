# Learning to Read a Script

## 1️⃣ Defining Colors for Terminal Output

```bash
GREEN='\033[0;32m'   # Green color for success messages
BLUE='\033[0;34m'    # Blue for headings
YELLOW='\033[0;33m'  # Yellow for warnings
RED='\033[0;31m'     # Red for errors
CYAN='\033[0;36m'    # Cyan for informational messages
MAGENTA='\033[0;35m' # Magenta for step headings
NC='\033[0m'         # No color (resets text color)
```

These ANSI escape codes change text color when printed in the terminal. Useful for clear visibility when running the script.

## 2️⃣ Displaying a Header Message

```bash
echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE}             KUBERNETES ZERO TO HERO - REVISED SCRIPT                 ${NC}"
echo -e "${BLUE}======================================================================${NC}"
```

- `echo -e` enables interpretation of escape sequences (like `\n` for new lines).
- `${BLUE}` ensures the text appears in blue, and `${NC}` resets the color.
- This creates a formatted heading in the terminal.

## 3️⃣ Setting Up the Project Directory

```bash
echo -e "${MAGENTA}[STEP 1] SETTING UP PROJECT DIRECTORY STRUCTURE${NC}"
```

Prints Step 1 in magenta for clarity.

```bash
PROJECT_DIR=~/k8s-master-app
echo -e "${CYAN}Creating project directory at ${PROJECT_DIR}...${NC}"
```

- Defines the base directory (`~/k8s-master-app`).
- Uses `${CYAN}` to make the message stand out.

## 4️⃣ Creating the Required Directory Structure

```bash
mkdir -p ${PROJECT_DIR}/{app,k8s/{base,volumes,networking,config,monitoring},scripts,data,config,logs}
```

`mkdir -p` ensures that directories are created recursively if they don’t exist.

### Breakdown of the structure:
- **`app/`** → Contains the Flask application.
- **`k8s/`** → Stores Kubernetes-related YAML configurations.
  - `base/` → Core Kubernetes configurations.
  - `volumes/` → Persistent storage configurations.
  - `networking/` → Service and ingress configurations.
  - `config/` → ConfigMaps and secrets.
  - `monitoring/` → Prometheus, Grafana, or other monitoring setups.
- **`scripts/`** → Holds helper scripts.
- **`data/`** → Stores app-related data (mounted volumes).
- **`config/`** → General configuration files.
- **`logs/`** → Stores application logs.

## 5️⃣ Handling WSL2 Directory Mounting Issues

```bash
echo -e "${CYAN}Creating local data directories instead of host mounts...${NC}"
```

Since **WSL2 (Windows Subsystem for Linux 2)** has issues with mounting host directories into Kubernetes,
instead of using external mounts, the script creates directories inside the project.

## 6️⃣ Creating Sample Configuration and Data Files

```bash
echo "This is a sample configuration file for our Kubernetes app" > ${PROJECT_DIR}/config/sample-config.txt
```
Creates a sample configuration file inside `config/`.

```bash
echo "Hello from the volume!" > ${PROJECT_DIR}/data/hello.txt
```
Creates a test file inside the `data/` directory.

```bash
echo "This file demonstrates volume mounting in Kubernetes" > ${PROJECT_DIR}/data/info.txt
```
Another sample text file to test volume mounting.

```bash
echo -e "${GREEN}✓ Project directory structure created${NC}"
```
Prints a success message in green.

## 7️⃣ Step 2: Creating the Flask Application

```bash
echo -e "${MAGENTA}[STEP 2] CREATING APPLICATION FILES${NC}"
echo -e "${CYAN}Building a Flask application that demonstrates volume mounting...${NC}"
```

Prints a heading in magenta and a message in cyan.

## 8️⃣ Creating the `app.py` File Using `cat`

```bash
cat > ${PROJECT_DIR}/app/app.py << 'EOL'
```

Writes content into `app.py` dynamically.

- `<< 'EOL'` → Everything between `EOL` markers is treated as input and written to the file.

## Import Required Libraries

```python
from flask import Flask, jsonify, render_template_string, request, redirect, url_for
import os  # Used to read environment variables
import socket  # Helps retrieve host-related information
import datetime  # For working with date and time
import json  # JSON formatting and responses
import logging  # Logging system for debugging and monitoring
import uuid  # Generates unique identifiers
import platform  # Gets system/platform information
import psutil  # Monitors system resource usage (CPU, memory, etc.)
import time  # Provides time-related functions
import threading  # Enables running background tasks
import sys  # System-specific parameters and functions
```

These libraries help build a Kubernetes-compatible Flask app.
They provide logging, system monitoring, HTTP handling, and configuration management.

## Flask App Initialization

```python
# Initialize Flask application
app = Flask(__name__)
```

Creates a Flask web application that serves HTTP requests.

## Logging Configuration

```python
# Set up logging to print to console and file
logging.basicConfig(
    level=logging.INFO,  # Log messages with INFO level or higher
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',  # Standard log format
    handlers=[
        logging.StreamHandler(sys.stdout),  # Print logs to console (stdout)
        logging.FileHandler(os.environ.get('LOG_PATH', '/app/app.log'))  # Save logs to a file
    ]
)
logger = logging.getLogger('k8s-master-app')
```

Logs are important in Kubernetes to debug and monitor applications.
This config:
- Logs messages both to the console and a file.
- The log file path is dynamically set using the `LOG_PATH` environment variable (defaults to `/app/app.log`).

## Reading Configuration from Environment Variables

```python
APP_NAME = os.environ.get('APP_NAME', 'k8s-master-app')
APP_VERSION = os.environ.get('APP_VERSION', '1.0.0')
ENVIRONMENT = os.environ.get('ENVIRONMENT', 'development')
DATA_PATH = os.environ.get('DATA_PATH', '/data')
CONFIG_PATH = os.environ.get('CONFIG_PATH', '/config')
LOG_PATH = os.environ.get('LOG_PATH', '/logs')
```

- **APP_NAME**: Reads the application name, defaulting to `'k8s-master-app'`.
- **APP_VERSION**: Fetches the app version, defaulting to `'1.0.0'`.
- **ENVIRONMENT**: Retrieves deployment environment (`development`, `staging`, `production`).
- **DATA_PATH**: Defines where app-related data is stored. Kubernetes volumes will mount data at this location.
- **CONFIG_PATH**: Defines the configuration file path. ConfigMaps in Kubernetes inject configuration files here.
- **LOG_PATH**: Specifies the log storage directory. Helps in centralized logging in Kubernetes.

## Host & System Information

```python
HOSTNAME = socket.gethostname()
IP_ADDRESS = socket.gethostbyname(HOSTNAME)
SYSTEM_INFO = platform.system() + " " + platform.release()
INSTANCE_ID = str(uuid.uuid4())
```

- **HOSTNAME**: Gets the container's hostname inside Kubernetes.
- **IP_ADDRESS**: Fetches the container's internal IP address.
- **SYSTEM_INFO**: Retrieves the OS type and version (e.g., "Linux 5.10.16").
- **INSTANCE_ID**: Generates a unique ID for each running instance.

## Flask Routes

### Health Check Route
```python
@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({'status': 'healthy', 'timestamp': datetime.datetime.utcnow()}), 200
```

- Kubernetes liveness & readiness probes will call this endpoint.
- Returns `200 OK` if the app is running fine.

### Root Route (Welcome Page)
```python
@app.route('/', methods=['GET'])
def home():
    return jsonify({
        'message': f'Welcome to {APP_NAME}!',
        'version': APP_VERSION,
        'instance_id': INSTANCE_ID,
        'hostname': HOSTNAME,
        'ip_address': IP_ADDRESS,
        'system_info': SYSTEM_INFO
    })
```

- Displays app details, hostname, and IP when you visit `/`.
- Helps debug which Kubernetes pod is serving a request.

### Resource Usage API
```python
@app.route('/resources', methods=['GET'])
def system_resources():
    return jsonify({
        'cpu_usage': psutil.cpu_percent(),
        'memory_usage': psutil.virtual_memory().percent,
        'disk_usage': psutil.disk_usage(DATA_PATH).percent
    })
```

- Reports CPU, Memory, and Disk Usage.
- Useful for monitoring pod resource consumption in Kubernetes.

## Background Log Writer

```python
def write_logs():
    while True:
        logger.info("Application is running...")
        time.sleep(30)  # Logs every 30 seconds
```

- Runs in a separate thread to continuously log messages.
- Helps in monitoring pod activity.

```python
threading.Thread(target=write_logs, daemon=True).start()
```

- Starts the background log writer when the app runs.

## Running the Flask App

```python
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

- Runs the app on port `5000`, listening on all interfaces (`0.0.0.0`).
- Kubernetes will map this port to a service.
