# Inheritance in Python

## 1️⃣ What is Inheritance?
Inheritance is a feature in object-oriented programming (OOP) that allows a class (child) to inherit attributes and methods from another class (parent).

- Promotes code reuse and reduces redundancy
- Establishes a hierarchical relationship between classes

## 2️⃣ Types of Inheritance

### 🔹 Single Inheritance
One child class inherits from one parent class.

```python
class Parent:
    def display(self):
        print("This is Parent class")

class Child(Parent):
    def show(self):
        print("This is Child class")

obj = Child()
obj.display()  # Accessing Parent class method
obj.show()     # Accessing Child class method
```

### 🔹 Multiple Inheritance
A child class inherits from multiple parent classes.

```python
class Parent1:
    def method1(self):
        print("Parent1 method")

class Parent2:
    def method2(self):
        print("Parent2 method")

class Child(Parent1, Parent2):
    def method3(self):
        print("Child method")

obj = Child()
obj.method1()  # From Parent1
obj.method2()  # From Parent2
obj.method3()  # From Child
```

### 🔹 Multilevel Inheritance
A class inherits from another child class.

```python
class Grandparent:
    def grandparent_method(self):
        print("Grandparent method")

class Parent(Grandparent):
    def parent_method(self):
        print("Parent method")

class Child(Parent):
    def child_method(self):
        print("Child method")

obj = Child()
obj.grandparent_method()
obj.parent_method()
obj.child_method()
```

### 🔹 Hierarchical Inheritance
One parent class is inherited by multiple child classes.

```python
class Parent:
    def parent_method(self):
        print("Parent method")

class Child1(Parent):
    def child1_method(self):
        print("Child1 method")

class Child2(Parent):
    def child2_method(self):
        print("Child2 method")

obj1 = Child1()
obj1.parent_method()
obj1.child1_method()

obj2 = Child2()
obj2.parent_method()
obj2.child2_method()
```

### 🔹 Hybrid Inheritance
A combination of multiple inheritance types.

```python
class A:
    def methodA(self):
        print("Method from A")

class B(A):
    def methodB(self):
        print("Method from B")

class C(A):
    def methodC(self):
        print("Method from C")

class D(B, C):
    def methodD(self):
        print("Method from D")

obj = D()
obj.methodA()
obj.methodB()
obj.methodC()
obj.methodD()
```

## 3️⃣ Super() Function
`super()` is used to call methods from the parent class inside the child class.

```python
class Parent:
    def __init__(self):
        print("Parent Constructor")

class Child(Parent):
    def __init__(self):
        super().__init__()
        print("Child Constructor")

obj = Child()
```

## 4️⃣ Method Overriding
A child class can override a method of the parent class.

```python
class Parent:
    def show(self):
        print("Parent method")

class Child(Parent):
    def show(self):  # Overriding the Parent method
        print("Child method")

obj = Child()
obj.show()
```

## 5️⃣ Method Overloading (Not Directly Supported in Python)
Python does not support method overloading like other languages. Instead, we can handle multiple arguments using default parameters or `*args`.

```python
class Example:
    def add(self, a=None, b=None):
        if a is not None and b is not None:
            return a + b
        elif a is not None:
            return a
        else:
            return 0

obj = Example()
print(obj.add(5, 10))  # 15
print(obj.add(5))      # 5
print(obj.add())       # 0
```

## 6️⃣ Private and Protected Members in Inheritance
- **Protected members** (`_var`): Accessible in child classes but not recommended to be accessed directly.
- **Private members** (`__var`): Not inherited by child classes but can be accessed using name mangling (`_ClassName__var`).

```python
class Parent:
    def __init__(self):
        self._protected_var = 10  # Protected
        self.__private_var = 20   # Private

class Child(Parent):
    def access_protected(self):
        print("Protected:", self._protected_var)
        # print("Private:", self.__private_var)  # Error

obj = Child()
obj.access_protected()
print(obj._Parent__private_var)  # Name mangling
```

## 7️⃣ Practical Example with OOP Concepts

```python
class Animal:
    def __init__(self, name):
        self.name = name
    def __str__(self):
        return f"Animal {self.name}"
    def speak(self):
        print(f"Animal {self.name} is speaking")

class Dog(Animal):
    def speak(self, age=None):
        if age:
            print(f"Dog {self.name} is barking and {age} years old")
        else:
            print(f"Dog {self.name} is barking")
    def __str__(self):
        return f"Dog {self.name}"
    def speaks(self, age, name):
        return f"Dog {name} is barking and {age} years old"

class Cat(Animal):
    def speak(self):
        print(f"Cat {self.name} is meowing")

class Bird(Animal):
    def speak(self):
        print(f"Bird {self.name} is chirping")

def main():
    dog = Dog("Buddy")
    dog.speak(10)
    print(dog)
    print(dog.speaks(10, "Buddy"))

if __name__ == "__main__":
    main()
```

## ✅ Key Takeaways
- **Inheritance** allows code reuse.
- `super()` helps in accessing parent class methods.
- **Method overriding** allows changing behavior of inherited methods.
- **Python doesn’t support traditional method overloading.**
- **Protected members** can be inherited, but private members need name mangling.
