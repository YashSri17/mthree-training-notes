# Exception Handling in Python

## 📌 What is Exception Handling?
Exception handling in Python allows you to handle runtime errors gracefully using `try`, `except`, `finally`, and `else` blocks. This prevents crashes and ensures smooth execution of the program.

## 🔹 Basic Syntax
```python
try:
    # Code that may cause an exception
    risky_code()
except ExceptionType:
    # Handle the exception
    handle_exception()
```

---

## 🔹 Using `try` and `except`
```python
try:
    num = int(input("Enter a number: "))
    result = 10 / num
    print("Result:", result)
except ZeroDivisionError:
    print("Error: Cannot divide by zero!")
except ValueError:
    print("Error: Invalid input. Please enter a number.")
except Exception as e:
    print(f"Unexpected Error: {e}")
```
✅ **Explanation:**
- `try`: Wraps the risky code.
- `except ZeroDivisionError`: Handles division by zero.
- `except ValueError`: Handles invalid inputs.
- `except Exception as e`: Catches any other exceptions.

---

## 🔹 Using `finally` (Always Executes)
```python
try:
    file = open("data.txt", "r")
    content = file.read()
except FileNotFoundError:
    print("Error: File not found!")
finally:
    print("Closing file...")
    file.close()
```
✅ **Use Case:** `finally` is useful for cleanup tasks like closing files or database connections.

---

## 🔹 Using `else` (Runs When No Exception Occurs)
```python
try:
    num = int(input("Enter a number: "))
    result = 100 / num
except ZeroDivisionError:
    print("Error: Cannot divide by zero!")
else:
    print("Success! The result is:", result)
```
✅ **Use Case:** `else` executes only if no exception occurs.

---

## 🔹 Raising Exceptions (`raise` Keyword)
```python
def check_age(age):
    if age < 18:
        raise ValueError("Age must be 18 or above!")
    print("Access granted.")

try:
    check_age(16)
except ValueError as e:
    print(f"Exception: {e}")
```
✅ **Use Case:** `raise` is used to manually throw exceptions when conditions aren’t met.

---

## 🔹 Custom Exceptions
```python
class CustomError(Exception):
    pass

try:
    raise CustomError("This is a custom exception!")
except CustomError as e:
    print(f"Caught CustomError: {e}")
```
✅ **Use Case:** Creating user-defined exceptions for specific scenarios.

---

## 🚀 Summary
✅ `try-except`: Handles exceptions.
✅ `finally`: Always executes (cleanup code).
✅ `else`: Runs when no exception occurs.
✅ `raise`: Manually raise exceptions.
✅ Custom exceptions: Define specific error types.

🛠 **Exception handling makes Python programs robust and error-free!** 🚀

