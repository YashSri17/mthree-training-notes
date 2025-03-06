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
