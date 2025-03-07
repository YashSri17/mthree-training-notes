# Method Overloading & Method Overriding in Python

## 📌 What is Method Overloading & Overriding?
- **Method Overloading**: Python does not support traditional method overloading (same method name with different parameters). Instead, we achieve it using default parameters or `*args`.
- **Method Overriding**: A child class provides a specific implementation of a method already defined in its parent class.

---

## 🔹 Example Code
```python
class Animal:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return f"Animal {self.name}"

    def speak(self):
        return f"Animal {self.name} is speaking"

# Method Overriding and Overloading
class Dog(Animal):
    def speak(self, age=0):  # Overloading using default argument
        return f"Dog {self.name} is barking and is {age} years old"

    def __str__(self):
        return f"Dog {self.name}"

class Cat(Animal):
    def speak(self):
        return f"Cat {self.name} is meowing"

class Bird(Animal):
    def speak(self):
        return f"Bird {self.name} is chirping"

# Main function to test
def main():
    dog1 = Animal("Biddy2")
    print(dog1.speak())

    dog = Dog("Buddy")
    print(dog.speak())  # Calls speak() with default age = 0
    print(dog.speak(10))  # Calls speak() with age = 10
    print(dog)  # Calls __str__()

    dog1 = Dog("Buddy1")
    print(dog1.speak(10))

if __name__ == "__main__":  # Fixed condition
    main()
```
# Method Overloading & Method Overriding in Python

## 📌 What is Method Overloading & Overriding?
- **Method Overloading**: Python does not support traditional method overloading (same method name with different parameters). Instead, we achieve it using default parameters or `*args`.
- **Method Overriding**: A child class provides a specific implementation of a method already defined in its parent class.

---

## 🔹 Example Code with Explanation
```python
class Animal:
    def __init__(self, name):  # Constructor initializes the name attribute
        self.name = name

    def __str__(self):  # String representation of the object
        return f"Animal {self.name}"

    def speak(self):  # Method to be overridden
        return f"Animal {self.name} is speaking"

# Method Overriding and Overloading
class Dog(Animal):
    def speak(self, age=0):  # Overloading using default argument
        return f"Dog {self.name} is barking and is {age} years old"

    def __str__(self):  # Overriding __str__ method to change output format
        return f"Dog {self.name}"

class Cat(Animal):
    def speak(self):  # Overriding speak() method
        return f"Cat {self.name} is meowing"

class Bird(Animal):
    def speak(self):  # Overriding speak() method
        return f"Bird {self.name} is chirping"

# Main function to test

def main():
    dog1 = Animal("Biddy2")  # Creating an Animal object
    print(dog1.speak())  # Calls speak() method from Animal class

    dog = Dog("Buddy")  # Creating a Dog object
    print(dog.speak())  # Calls Dog's speak() method with default age = 0
    print(dog.speak(10))  # Calls Dog's speak() method with age = 10
    print(dog)  # Calls __str__() method, overridden in Dog class

    dog1 = Dog("Buddy1")  # Creating another Dog object
    print(dog1.speak(10))  # Calls Dog's speak() with age = 10

if __name__ == "__main__":  # Ensures that main() runs only when script is executed directly
    main()
```

## 🔹 Code Explanation (Line by Line)
1. **`class Animal:`** → Defines a base class `Animal`.
2. **`def __init__(self, name):`** → Constructor initializes the `name` attribute.
3. **`def __str__(self):`** → Overridden method to return a formatted string representation.
4. **`def speak(self):`** → Base method that will be overridden in child classes.
5. **`class Dog(Animal):`** → `Dog` class inherits from `Animal`.
6. **`def speak(self, age=0):`** → Overloaded method using a default parameter.
7. **`def __str__(self):`** → Overridden `__str__` method to modify string output.
8. **`class Cat(Animal):`** → `Cat` class inherits from `Animal`.
9. **`def speak(self):`** → Overrides `speak()` from `Animal`.
10. **`class Bird(Animal):`** → `Bird` class inherits from `Animal`.
11. **`def speak(self):`** → Overrides `speak()` from `Animal`.
12. **`def main():`** → Defines the main function.
13. **`dog1 = Animal("Biddy2")`** → Creates an `Animal` object.
14. **`print(dog1.speak())`** → Calls the `speak()` method of `Animal`.
15. **`dog = Dog("Buddy")`** → Creates a `Dog` object.
16. **`print(dog.speak())`** → Calls `speak()` with default `age=0`.
17. **`print(dog.speak(10))`** → Calls `speak()` with `age=10`.
18. **`print(dog)`** → Calls `__str__()` method of `Dog`.
19. **`dog1 = Dog("Buddy1")`** → Creates another `Dog` object.
20. **`print(dog1.speak(10))`** → Calls `speak()` with `age=10`.
21. **`if __name__ == "__main__":`** → Ensures `main()` runs only if the script is executed directly.


---

## 🔹 Explanation
### ✅ **Method Overloading in Python**
Python does **not** support traditional method overloading like other languages (Java, C++). Instead, we achieve similar behavior using:
1. Default parameter values (e.g., `def speak(self, age=0)`)
2. `*args` or `**kwargs` for flexible arguments

### ✅ **Method Overriding in Python**
- The `speak()` method in `Dog`, `Cat`, and `Bird` classes **overrides** the `speak()` method in `Animal`.
- When `speak()` is called on a `Dog` object, the overridden method in `Dog` runs instead of the one in `Animal`.

---

## 🚀 Summary
✅ **Method Overloading**: Achieved using default arguments or `*args`.
✅ **Method Overriding**: Child class provides a new definition for a parent class method.
✅ **Usage**: In OOP to enhance code reusability and flexibility.

🐍 **Python makes method handling simple and efficient!** 🚀

