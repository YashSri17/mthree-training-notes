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

# Tracking Request Count & Application Metrics

## 1️⃣ Initializing Metrics

```python
request_count = 0
start_time = time.time()
```
- `request_count = 0` → Tracks the total number of requests received by the Flask app.
- `start_time = time.time()` → Records the time when the application starts running (in seconds since epoch).

```python
metrics = {
    'requests': 0,
    'errors': 0,
    'data_reads': 0,
    'data_writes': 0
}
```
### Key Performance Indicators (KPIs):
- `'requests'` → Total number of HTTP requests received.
- `'errors'` → Number of errors encountered.
- `'data_reads'` → Count of times data is read from a file or database.
- `'data_writes'` → Count of times data is written to a file or database.

## 2️⃣ Defining a Background Worker Function

```python
def background_worker():
    """
    Simulate background work to demonstrate resource usage.
    In a real app, this might be processing tasks, etc.
    """
    logger.info("Background worker started")
    counter = 0
    while True:
        # Simulate CPU workload (e.g., calculating prime numbers)
        counter += 1
        if counter % 1000 == 0:
            logger.debug(f"Background worker tick: {counter}")
        time.sleep(0.1)  # Avoid consuming too much CPU
```
### Functionality:
✅ Simulates workload  
✅ Tracks resource usage  
✅ Logs progress periodically  
✅ Prevents CPU overload using `time.sleep(0.1)`

## 3️⃣ Starting the Background Worker Thread

```python
worker_thread = threading.Thread(target=background_worker, daemon=True)
worker_thread.start()
```
- Runs `background_worker()` in a separate thread.
- `daemon=True` → Ensures the worker stops automatically when the main process exits.

## 4️⃣ Defining the Main Route (`/`)

```python
@app.route('/')
def index():
    """Main page showing application status and mounted volume information"""
    global request_count, metrics
    request_count += 1
    metrics['requests'] += 1
    logger.info(f"Request to index page from {request.remote_addr}")

    system_info = {
        'hostname': socket.gethostname(),
        'platform': platform.platform(),
        'python_version': platform.python_version(),
        'cpu_count': psutil.cpu_count(),
        'memory': f"{psutil.virtual_memory().total / (1024 * 1024):.1f} MB",
        'uptime': f"{time.time() - start_time:.1f} seconds"
    }

    resource_usage = {
        'cpu_percent': psutil.cpu_percent(),
        'memory_percent': psutil.virtual_memory().percent,
        'disk_usage': f"{psutil.disk_usage('/').percent}%"
    }

    volumes = {}

    try:
        data_files = os.listdir(DATA_PATH)
        volumes['data'] = {
            'path': DATA_PATH,
            'files': data_files,
            'status': 'mounted' if data_files else 'empty'
        }
        metrics['data_reads'] += 1
    except Exception as e:
        volumes['data'] = {'path': DATA_PATH, 'error': str(e), 'status': 'error'}
        metrics['errors'] += 1

    try:
        config_files = os.listdir(CONFIG_PATH)
        volumes['config'] = {
            'path': CONFIG_PATH,
            'files': config_files,
            'status': 'mounted' if config_files else 'empty'
        }
    except Exception as e:
        volumes['config'] = {'path': CONFIG_PATH, 'error': str(e), 'status': 'error'}
        metrics['errors'] += 1

    try:
        logs_files = os.listdir(LOG_PATH)
        volumes['logs'] = {
            'path': LOG_PATH,
            'files': logs_files,
            'status': 'mounted' if logs_files else 'empty'
        }
    except Exception as e:
        volumes['logs'] = {'path': LOG_PATH, 'error': str(e), 'status': 'error'}
        metrics['errors'] += 1

    return jsonify({
        'message': f'Welcome to {APP_NAME}!',
        'version': APP_VERSION,
        'instance_id': INSTANCE_ID,
        'hostname': system_info['hostname'],
        'ip_address': IP_ADDRESS,
        'system_info': system_info,
        'resource_usage': resource_usage,
        'volumes': volumes
    })
```
# Object-Oriented Programming (OOP) in Python – Theory & Concepts

## Introduction to OOP
Object-Oriented Programming (OOP) is a programming paradigm that organizes software design around objects rather than functions and logic. Objects represent real-world entities with attributes (data) and behaviors (methods/functions).

## Advantages of OOP
✅ **Code Reusability** – Inheritance allows code to be reused, reducing redundancy.
✅ **Modularity** – Code is structured into objects, making it more organized and manageable.
✅ **Scalability** – Easy to extend and modify as new features can be added.
✅ **Security** – Encapsulation hides sensitive data and prevents direct modification.

## Key Principles of OOP (4 Pillars)

### 1. Encapsulation
Encapsulation is the technique of restricting direct access to data (variables) and allowing modifications only through methods.
- Protects the integrity of the object’s data.
- Implemented using private (`__variable`) and protected (`_variable`) attributes.

```python
class BankAccount:
    def __init__(self, balance):
        self.__balance = balance  # Private variable

    def deposit(self, amount):
        self.__balance += amount

    def get_balance(self):
        return self.__balance

acc = BankAccount(5000)
print(acc.get_balance())  # Output: 5000
acc.deposit(2000)
print(acc.get_balance())  # Output: 7000
```
🔹 `__balance` cannot be accessed directly outside the class.

### 2. Abstraction
Abstraction hides complex implementation details and only exposes essential features.
- Implemented using abstract classes and methods in Python via the `ABC` module.

```python
from abc import ABC, abstractmethod

class Vehicle(ABC):
    @abstractmethod
    def start_engine(self):
        pass  # Abstract method, no implementation

class Car(Vehicle):
    def start_engine(self):
        print("Car engine started!")

c = Car()
c.start_engine()  # Output: Car engine started!
```
🔹 The `Vehicle` class is abstract and cannot be instantiated directly.

### 3. Inheritance
Inheritance allows a child class to inherit attributes and methods from a parent class.
- Promotes code reuse and hierarchical relationships between classes.

#### Types of Inheritance:
1️⃣ **Single Inheritance** – One parent, one child.
2️⃣ **Multilevel Inheritance** – Inheriting from an inherited class.
3️⃣ **Multiple Inheritance** – A class inherits from multiple parent classes.

#### Example (Single Inheritance):
```python
class Animal:
    def speak(self):
        print("Animal makes a sound")

class Dog(Animal):  # Inheriting from Animal
    def speak(self):
        print("Dog barks")

d = Dog()
d.speak()  # Output: Dog barks
```
🔹 `Dog` inherits from `Animal` but overrides the `speak()` method.

### 4. Polymorphism
Polymorphism allows methods to have the same name but different behaviors depending on the object.
- Achieved using **method overriding** and **method overloading (via default arguments).**

#### Example (Method Overriding):
```python
class Bird:
    def fly(self):
        print("Most birds can fly")

class Penguin(Bird):
    def fly(self):
        print("Penguins can't fly")

b = Bird()
p = Penguin()
b.fly()  # Output: Most birds can fly
p.fly()  # Output: Penguins can't fly
```
🔹 The `Penguin` class overrides the `fly()` method.

## Other Important OOP Concepts

### 1. Classes and Objects
- A **class** is a blueprint/template for creating objects.
- An **object** is an instance of a class.

```python
class Car:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model

    def display(self):
        print(f"Car: {self.brand} {self.model}")

car1 = Car("Tesla", "Model S")  # Object creation
car1.display()  # Output: Car: Tesla Model S
```
🔹 `car1` is an instance of the `Car` class.

### 2. Constructor (`__init__` Method)
- The constructor method initializes object attributes when an object is created.
- It is called automatically when an object is instantiated.

```python
class Student:
    def __init__(self, name, age):
        self.name = name
        self.age = age

s1 = Student("Alice", 20)
print(s1.name)  # Output: Alice
```
🔹 The `__init__` method runs automatically to assign values.

### 3. Method Overloading
- Python does not support true method overloading but allows default arguments to achieve similar functionality.

```python
class Math:
    def add(self, a, b=0, c=0):
        return a + b + c

m = Math()
print(m.add(2))      # Output: 2
print(m.add(2, 3))   # Output: 5
print(m.add(2, 3, 4)) # Output: 9
```
🔹 The function adjusts behavior based on the number of arguments.

### 4. Operator Overloading
- Python allows overloading operators (e.g., `+`, `-`, `*`) to work with user-defined objects.

```python
class Point:
    def __init__(self, x):
        self.x = x

    def __add__(self, other):
        return Point(self.x + other.x)

p1 = Point(5)
p2 = Point(10)
p3 = p1 + p2  # Calls __add__()
print(p3.x)   # Output: 15
```
🔹 The `+` operator is customized for `Point` objects.

### 5. Multiple Inheritance
- A class inherits from multiple parent classes.

```python
class A:
    def show(self):
        print("Class A")

class B:
    def show(self):
        print("Class B")

class C(A, B):  # Multiple Inheritance
    pass

obj = C()
obj.show()  # Output: Class A (Method Resolution Order - MRO)
```
🔹 Python follows the **Method Resolution Order (MRO)** to decide which method to call.

### 6. Class vs Static Methods
- **Instance Method** – Works with object attributes (`self`).
- **Class Method (@classmethod)** – Works with class variables (`cls`).
- **Static Method (@staticmethod)** – Independent of class and instance.

```python
class Example:
    class_var = 10

    @classmethod
    def class_method(cls):
        print(f"Class method, class_var: {cls.class_var}")

    @staticmethod
    def static_method():
        print("Static method called")

Example.class_method()  # Output: Class method, class_var: 10
Example.static_method() # Output: Static method called
```

## Conclusion
- OOP makes Python code more **modular, reusable, and maintainable**.
- It is widely used in **software development, game design, data analysis, and system programming**.
- Mastering **classes, objects, inheritance, polymorphism, and encapsulation** is key to writing efficient object-oriented programs.

