# Deep and Shallow Copy in Python

## What is Copying?
Copying an object means creating a duplicate of the original object. However, the way the copy is created affects whether changes to nested objects (like lists, dictionaries, or class attributes) affect the copied version.

### 1️⃣ Shallow Copy
A **shallow copy** creates a new object but does not create copies of nested objects; instead, it copies references to them. Changes in the original object's nested attributes will affect the shallow copy.

### 2️⃣ Deep Copy
A **deep copy**, on the other hand, creates a new object and also recursively copies all nested objects, ensuring that changes in the original object's attributes do not affect the deep copy.

---

## Code Implementation

```python
import copy

class Person:
    def __init__(self, name, address):
        self.name = name
        self.address = address
        
    def __repr__(self):
        return f"Person(name={self.name}, address={self.address})"

class Address:
    def __init__(self, city, country):
        self.city = city
        self.country = country
        
    def __repr__(self):
        return f"Address(city={self.city}, country={self.country})"

# Create a person with an address
address = Address("New York", "USA")
person = Person("John", address)

# Create a shallow copy
shallow_person = copy.copy(person)

# Create a deep copy
deep_person = copy.deepcopy(person)

# Verify the objects are different
print(f"Original person ID: {id(person)}")
print(f"Shallow copy person ID: {id(shallow_person)}")
print(f"Deep copy person ID: {id(deep_person)}")

# But the address in the shallow copy is the same object
print(f"Original address ID: {id(person.address)}")
print(f"Shallow copy address ID: {id(shallow_person.address)}")
print(f"Deep copy address ID: {id(deep_person.address)}")

# Now change the original address
person.address.city = "Boston"

# Check all objects
print(f"Original person: {person}")
print(f"Shallow copy person: {shallow_person}")  # The city will be Boston
print(f"Deep copy person: {deep_person}")        # The city will still be New York
```

---

## Code Explanation

1. **Import `copy` module**: Required to perform shallow and deep copies.
2. **Define `Person` and `Address` classes**:
   - `Person` has `name` and `address` attributes.
   - `Address` has `city` and `country` attributes.
   - `__repr__` methods return readable representations of objects.
3. **Create an `Address` object** and use it in a `Person` instance.
4. **Perform a shallow copy** using `copy.copy(person)`:
   - This copies the `Person` object but maintains the reference to the original `Address` object.
5. **Perform a deep copy** using `copy.deepcopy(person)`:
   - This copies the `Person` object and also creates a new `Address` object.
6. **Print object IDs**:
   - The `Person` objects have different memory addresses.
   - The `Address` object remains the same for `shallow_person` but is different for `deep_person`.
7. **Modify the `city` attribute** of the original `Person` object.
8. **Print results**:
   - The shallow copy reflects the change because it shares the same `Address` instance.
   - The deep copy retains the original `Address` instance, showing no changes.

---

## Key Takeaways
✅ **Shallow Copy**: Copies references to objects, meaning nested objects remain shared.
✅ **Deep Copy**: Recursively copies objects, making the copy independent of the original.
✅ **Use Cases**:
   - Shallow copies are useful when you need a duplicate object but don’t want to duplicate large data structures.
   - Deep copies are useful when you need an independent copy that won’t be affected by changes to the original object.

---

