# 🚀 Python Concepts Notes

## 🏛️ 1. Inheritance
Inheritance allows a class (child class) to inherit the properties and methods of another class (parent class).

### 🔹 Types of Inheritance:
| Type | Description |
|------|------------|
| Single Inheritance | One child class inherits from one parent class |
| Multiple Inheritance | A child class inherits from multiple parent classes |
| Multilevel Inheritance | A class inherits from a derived class |
| Hierarchical Inheritance | Multiple child classes inherit from a single parent class |
| Hybrid Inheritance | A combination of different types of inheritance |

📖 [For detailed notes](https://www.geeksforgeeks.org/inheritance-in-python/)

---

## 🔄 2. Deep Copy vs. Shallow Copy
### 🔹 Shallow Copy
- Copies references to objects, not the objects themselves.
- Changes in copied object affect the original.

### 🔹 Deep Copy
- Creates a completely independent copy.
- Changes in copied object do not affect the original.

### 📊 Comparison:
| Copy Type | Copies References | Copies Actual Objects | Independent Changes |
|-----------|-------------------|-----------------------|---------------------|
| Shallow Copy | Yes | No | No |
| Deep Copy | No | Yes | Yes |

📖 [For my detailed notes](https://www.geeksforgeeks.org/copy-python-deep-copy-shallow-copy/)

---

## 📂 3. File Handling
File handling in Python allows reading, writing, and managing files.

### 🔹 Common File Modes:
| Mode | Description |
|------|------------|
| `r`  | Read mode (default) |
| `w`  | Write mode (overwrites file) |
| `a`  | Append mode (adds to file) |
| `r+` | Read and write mode |
| `w+` | Write and read mode (overwrites file) |

📖 [For my detailed notes](https://www.geeksforgeeks.org/file-handling-python/) 

---

## ⚠️ 4. Try and Except
Exception handling prevents runtime errors from crashing the program.

### 🔹 Exception Handling Structure:
```
try:
    # Code that may cause an exception
except ExceptionType:
    # Code to handle the exception
finally:
    # Code that runs regardless of an exception
```

### 🚨 Common Exceptions in Python:
| Exception | Description |
|-----------|------------|
| `ZeroDivisionError` | Raised when division by zero occurs |
| `TypeError` | Raised when an operation is performed on an inappropriate type |
| `ValueError` | Raised when an invalid value is used |
| `FileNotFoundError` | Raised when a file does not exist |

📖 [For my detailed notes](https://www.geeksforgeeks.org/python-try-except/) 

---

## 🔄 5. Method Overloading and Overriding

### 🔹 Method Overloading
- Python does not support true method overloading.
- Achieved using default arguments.

### 🔹 Method Overriding
- A subclass provides a specific implementation of a method already defined in its superclass.

### 📊 Comparison:
| Feature | Method Overloading | Method Overriding |
|---------|-------------------|-------------------|
| Definition | Multiple methods with the same name but different parameters | Redefining a parent class method in a subclass |
| Support in Python | Not natively supported (achieved using default arguments) | Fully supported |
| Usage | Used to perform different operations based on parameter count | Used to change the behavior of an inherited method |

📖 [For my detailed notes](https://www.geeksforgeeks.org/method-overloading-and-overriding-in-python/) 

---

This document provides a concise overview of these important Python concepts with structured tables, links, and explanations for better understanding. 🎯
