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

