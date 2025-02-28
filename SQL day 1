# MTHREE SQL Training - Day 1

## Introduction
This document covers fundamental SQL concepts, including databases, RDBMS, and commonly used SQL commands.

## 📌 What is a Database?
A database is an electronically stored, systematic collection of data. It can include words, numbers, images, videos, and files. A **Database Management System (DBMS)** is used to store, retrieve, and edit data.

## 📌 What is RDBMS?
**Relational Database Management System (RDBMS)** is a software program that manages relational databases. It allows for storing, updating, and retrieving data efficiently.

### 🔹 Key Features of RDBMS:
- Most popular database system used by organizations.
- Forms the basis of modern databases like MySQL, PostgreSQL, etc.
- Follows **ACID properties** (Atomicity, Consistency, Isolation, Durability).
- Optimizes query execution.

## 📌 What is SQL?
**Structured Query Language (SQL)** is the standard programming language for managing and manipulating relational databases.

### 🔹 SQL Example:
```sql
SELECT * FROM employees WHERE Salary > 55000.00;
```

---

## 📌 SQL Basics - Common Commands

### 🔹 SELECT (Retrieve Data)
```sql
SELECT column1, column2 FROM table_name;
```
**Example:** Retrieve names and ages of all students.
```sql
SELECT name, age FROM students;
```

### 🔹 INSERT (Add Data)
```sql
INSERT INTO table_name (column1, column2) VALUES (value1, value2);
```
**Example:** Add a new student.
```sql
INSERT INTO students (name, age, grade) VALUES ('John', 18, 'A');
```

### 🔹 UPDATE (Modify Data)
```sql
UPDATE table_name SET column1 = value1 WHERE condition;
```
**Example:** Change John's grade.
```sql
UPDATE students SET grade = 'B' WHERE name = 'John';
```

### 🔹 DELETE (Remove Data)
```sql
DELETE FROM table_name WHERE condition;
```
**Example:** Remove students older than 20.
```sql
DELETE FROM students WHERE age > 20;
```

### 🔹 CREATE TABLE (Define Structure)
```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
```

### 🔹 ALTER TABLE (Modify Structure)
```sql
ALTER TABLE students ADD grade CHAR(1);
```

### 🔹 WHERE (Filter Data)
```sql
SELECT name FROM students WHERE grade = 'A';
```

### 🔹 ORDER BY (Sorting)
```sql
SELECT name, age FROM students ORDER BY age DESC;
```

### 🔹 GROUP BY (Aggregation)
```sql
SELECT grade, COUNT(*) FROM students GROUP BY grade;
```

---

## 📌 SQL Joins
SQL joins combine rows from multiple tables based on related columns.

### 🔹 INNER JOIN (Matching Data in Both Tables)
```sql
SELECT students.name, courses.course_name  
FROM students  
INNER JOIN courses ON students.course_id = courses.course_id;
```

### 🔹 LEFT JOIN (All from Left + Matches from Right)
```sql
SELECT students.name, courses.course_name  
FROM students  
LEFT JOIN courses ON students.course_id = courses.course_id;
```

### 🔹 RIGHT JOIN (All from Right + Matches from Left)
```sql
SELECT students.name, courses.course_name  
FROM students  
RIGHT JOIN courses ON students.course_id = courses.course_id;
```

### 🔹 FULL OUTER JOIN (All Data from Both Tables)
```sql
SELECT students.name, courses.course_name  
FROM students  
FULL JOIN courses ON students.course_id = courses.course_id;
```

### 🔹 CROSS JOIN (Cartesian Product)
```sql
SELECT students.name, courses.course_name  
FROM students  
CROSS JOIN courses;
```

### 🔹 SELF JOIN (Join with Itself)
```sql
SELECT a.name AS student1, b.name AS student2  
FROM students a, students b  
WHERE a.course_id = b.course_id AND a.name != b.name;
```

---

## 📌 SQL Leetcode Practice Questions
### 🔹 1️⃣ Recyclable and Low-Fat Products
```sql
SELECT product_id FROM Products WHERE low_fats = 'Y' AND recyclable = 'Y';
```
[🔗 Question Link](https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50)

### 🔹 2️⃣ Find Customer Referee
```sql
SELECT name FROM Customer WHERE referee_id != 2 OR referee_id IS NULL;
```
[🔗 Question Link](https://leetcode.com/problems/find-customer-referee/?envType=study-plan-v2&envId=top-sql-50)

### 🔹 3️⃣ Big Countries
```sql
SELECT name, population, area FROM World WHERE area >= 3000000 OR population >= 25000000;
```
[🔗 Question Link](https://leetcode.com/problems/big-countries/?envType=study-plan-v2&envId=top-sql-50)

### 🔹 4️⃣ Article Views I
```sql
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY author_id ASC;
```
[🔗 Question Link](https://leetcode.com/problems/article-views-i/?envType=study-plan-v2&envId=top-sql-50)

### 🔹 5️⃣ Invalid Tweets
```sql
SELECT tweet_id FROM Tweets WHERE LENGTH(content) > 15;
```
[🔗 Question Link](https://leetcode.com/problems/invalid-tweets/?envType=study-plan-v2&envId=top-sql-50)

### 🔹 6️⃣ Replace Employee ID with Unique Identifier
```sql
SELECT e.unique_id, emp.name FROM Employees emp LEFT JOIN EmployeeUNI e ON emp.id = e.id;
```
[🔗 Question Link](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/?envType=study-plan-v2&envId=top-sql-50)

### 🔹 7️⃣ Product Sales Analysis I
```sql
SELECT p.product_name, s.year, s.price FROM Sales s JOIN Product p ON s.product_id = p.product_id;
```
[🔗 Question Link](https://leetcode.com/problems/product-sales-analysis-i/?envType=study-plan-v2&envId=top-sql-50)

### 🔹 8️⃣ Customer Who Visited But Did Not Make Any Transactions
```sql
SELECT v.customer_id, COUNT(*) AS count_no_trans FROM Visits v LEFT JOIN Transactions t ON v.visit_id = t.visit_id WHERE t.transaction_id IS NULL GROUP BY v.customer_id;
```
[🔗 Question Link](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/?envType=study-plan-v2&envId=top-sql-50)

---

## 🚀 Conclusion
This README provides an introduction to SQL, common commands, joins, and practice problems to improve SQL skills. Happy coding! 🎯
