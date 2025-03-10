# 💻 NumPy, Pandas, and SQLAlchemy Notes – With Theory & Examples

## 🌟 NumPy – Numerical Python

### ➤ Why NumPy is Important:
- Fundamental library for scientific computing in Python.
- Works with arrays/matrices and provides high-performance operations.

### ✅ Key Applications of NumPy:
- Creating arrays and matrices.
- Performing mathematical operations.
- Performing statistical analysis.
- Linear algebra operations.
- Fourier transformations.
- Random number generation.
- Performing different types of regressions (linear, polynomial, exponential, etc).

### 📌 Array Creation:
```python
import numpy as np

arr = np.array([1, 2, 3, 4, 5])
arr_2d = np.array([[1, 2, 3], [4, 5, 6]])

print(arr)
print(arr_2d)
```

### 📌 Special Arrays:
```python
arr_random = np.random.rand(3, 4)
zeros_array = np.zeros((3, 4))
ones_array = np.ones((3, 4))
full_array = np.full((3, 4), 10)

print(arr_random)
print(zeros_array)
print(ones_array)
print(full_array)
```

### 📌 Array Range:
```python
arr_range = np.arange(10, 20, 0.5)
print(arr_range)
```

### ➕ Matrix Operations:
```python
matrix_1 = np.array([[1, 2, 3], [4, 5, 6]])
matrix_2 = np.array([[1, 2, 3], [4, 5, 6]])

print(matrix_1 + matrix_2)  # Addition
print(matrix_1 - matrix_2)  # Subtraction
print(matrix_1 * matrix_2)  # Element-wise Multiplication
print(matrix_1 / matrix_2)  # Element-wise Division
print(matrix_1 ** matrix_2) # Power
print(matrix_1.T)           # Transpose
```

### 🔢 Statistical Functions:
```python
arr = np.array([1, 2, 3, 4, 5])
print(np.mean(arr))       # Mean
print(np.median(arr))     # Median
print(np.std(arr))        # Standard Deviation
print(np.var(arr))        # Variance
```

### 🔢 Finding Mode:
```python
import statistics as st

arr1 = np.array([[1, 2, 3], [4, 2, 6], [2, 8, 9]])
flat_arr = arr1.flatten()
print("Mode:", st.mode(flat_arr))
```

---

## 🧮 Pandas – Data Analysis Library

### ➤ What is Pandas?
- Pandas provides high-level data structures and tools for analysis.

### 📌 Series Creation:
```python
import pandas as pd

series = pd.Series([1, 2, 3, 4, 5])
print(series)

series_2 = pd.Series([1, 2, 3, 4, 5], index=['a', 'b', 'c', 'd', 'e'])
print(series_2)
```

### 📌 DataFrame Creation:
```python
data = {
    'Name': ['John', 'Jane', 'Jim', 'Jill'],
    'Age': [20, 21, 22, 23],
    'City': ['New York', 'Los Angeles', 'Chicago', 'Houston']
}

df = pd.DataFrame(data)
print(df)
```

### 📌 Loading CSV into DataFrame:
```python
df_csv = pd.read_csv('data.csv')
print(df_csv)
```

---

## 💽 SQLAlchemy – Python SQL Toolkit & ORM

### ➤ Why SQLAlchemy?
- SQL toolkit and ORM to interact with databases.
- Helps perform operations using Python instead of SQL syntax.

### 📌 Basic Setup:
```python
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, ForeignKey, insert, select

engine = create_engine('sqlite:///data', echo=True)
metadata = MetaData()
```

### 📌 Creating Tables:
```python
users = Table('users', metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String),
    Column('age', Integer),
    Column('city', String),
)

posts = Table('posts', metadata,
    Column('id', Integer, primary_key=True),
    Column('title', String),
    Column('content', String),
    Column('user_id', Integer, ForeignKey('users.id')),
)

metadata.create_all(engine)
```

### 📌 Inserting Data:
```python
with engine.connect() as con:
    insert_stmt = insert(users).values(name='John', age=20, city='New York')
    result = con.execute(insert_stmt)
    print(result.rowcount)

    insert_stmt = insert(posts).values(title='Post 1', content='Content 1', user_id=1)
    result = con.execute(insert_stmt)
    print(result.rowcount)

    con.commit()
```

### 📌 Selecting Data:
```python
    select_stmt = select(users)
    result = con.execute(select_stmt)
    for row in result:
        print(row)

    select_stmt = select(posts)
    result = con.execute(select_stmt)
    for row in result:
        print(row)
