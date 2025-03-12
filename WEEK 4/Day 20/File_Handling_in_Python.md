# File Handling in Python

File handling in Python allows users to perform operations such as creating, reading, writing, appending, and deleting files. Additionally, the `os` module enables advanced file and directory management.

# File Handling in Python

## Overview
File handling in Python allows you to perform operations like creating, reading, writing, appending, and deleting files. The `os` module helps with file and directory management.

## What is File Handling?
File handling refers to the process of managing files using programming techniques. In Python, we use built-in functions to perform operations such as:
- Creating a file
- Writing to a file
- Reading from a file
- Appending to a file
- Deleting a file

Python provides functions for file handling through the `open()` method, which is used to open files in different modes:

| Mode | Description |
|------|-------------|
| `r`  | Read mode (default). Opens file for reading; error if the file does not exist. |
| `w`  | Write mode. Creates a new file or overwrites if the file exists. |
| `a`  | Append mode. Adds new content to the file without deleting existing data. |
| `x`  | Exclusive creation mode. Creates a new file; error if the file already exists. |
| `t`  | Text mode (default). Handles file as text. |
| `b`  | Binary mode. Handles file in binary format. |
| `+`  | Read and write mode combined. |


## Prerequisites
Ensure that Python is installed on your system by running the following command:
```bash
python --version
```

## File Operations in Python

### 1. Creating a File
Creates a new file and writes content to it.
```python
def create_file():
    with open("text1.txt", "w") as file:
        file.write("Hello, World!")
```
This will create a file named `text1.txt` with the text "Hello, World!".

---

### 2. Writing to a File
Overwrites content in the file.
```python
def write_to_file():
    with open("text1.txt", "w") as file:
        file.write("Overwriting content!")
```
This function completely replaces the existing file content with "Overwriting content!".

---

### 3. Reading from a File
Reads and prints the file content.
```python
def read_from_file():
    with open("text1.txt", "r") as file:
        print(file.read())
```
This function opens `text1.txt` in read mode and prints its content to the console.

---

### 4. Appending to a File
Appends new content without erasing the existing text.
```python
def append_to_file():
    with open("text1.txt", "a") as file:
        file.write("\nAppending new content!")
```
This function adds "Appending new content!" at the end of the file.

---

### 5. Deleting a File
Deletes the specified file.
```python
import os

def delete_file():
    if os.path.exists("text1.txt"):
        os.remove("text1.txt")
        print("File deleted.")
    else:
        print("File does not exist.")
```
This function checks if `text1.txt` exists and deletes it.

---

### 6. Checking if a File Exists
Verifies whether a file is present.
```python
def check_if_file_exists():
    if os.path.exists("text1.txt"):
        print("File exists")
    else:
        print("File does not exist")
```
This function checks for the existence of `text1.txt` before attempting operations on it.

---

### 7. Getting the Current Working Directory
Retrieves the path of the current working directory.
```python
import os

def get_current_working_directory():
    print(os.getcwd())
```
This function prints the directory where the script is being executed.

---

### 8. Listing All Files in a Directory
Lists files and folders in the current directory.
```python
import os

def list_files_in_directory():
    print(os.listdir())
```
This function prints all files and folders in the working directory.

---

### 9. Getting the Size of a File
Retrieves the file size in bytes.
```python
import os

def get_size_of_file():
    print(os.path.getsize("text1.txt"))
```
This function returns the size of `text1.txt` in bytes.

---

### 10. Getting the Last Modified Time of a File
Retrieves the last modification time of the file.
```python
import os

def get_last_modified_time_of_file():
    print(os.path.getmtime("text1.txt"))
```
This function prints the last modified timestamp of `text1.txt`.

---

### 11. Getting the File Type (Extension)
Extracts the file extension.
```python
import os

def get_file_extension():
    print(os.path.splitext("text1.txt")[1])
```
This function returns the file extension, such as `.txt`.

---

### 12. Getting the File Name
Extracts the file name from a path.
```python
import os

def get_file_name():
    print(os.path.basename("text1.txt"))
```
This function prints only the name of the file without the directory path.

---

### 13. Getting the File Directory
Extracts the directory path from the full file path.
```python
import os

def get_file_directory():
    print(os.path.dirname("/absolute/path/to/text1.txt"))
```
This function returns the directory path where the file is located.

---

## Running the Script
To test all functions, execute the following script:
```python
if __name__ == "__main__":
    create_file()
    write_to_file()
    read_from_file()
    append_to_file()
    delete_file()
    create_file()
    write_to_file()
    check_if_file_exists()
    get_current_working_directory()
    list_files_in_directory()
    get_size_of_file()
    get_last_modified_time_of_file()
    get_file_extension()
    get_file_name()
```

## Conclusion
Python provides extensive capabilities for file handling, allowing users to manage files effectively. Understanding these operations is essential for working with data files, configuration files, and logs in real-world applications.

---
