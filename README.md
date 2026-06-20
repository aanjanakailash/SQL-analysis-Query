# Sales Analysis Using SQL

## Project Overview

This project focuses on analyzing retail sales data using SQL. The objective is to extract meaningful business insights related to sales performance, profitability, customer behavior, product performance, and regional trends.

The project demonstrates both basic and advanced SQL concepts commonly used in real-world data analytics projects.

---

## Dataset Information

The project uses three tables:

### 1. mainsales2

Contains transactional sales data.

**Columns:**

* Order_ID
* Order_Date
* Customer_ID
* Region
* State
* City
* Product_ID
* Quantity
* Unit_Price
* Discount_Percent
* Unit_Cost
* Shipping_Cost
* Marketing_Cost
* Total_Sales
* Total_Cost
* Profit
* Payment_Mode
* Sales_Channel
* Order_Status
* Salesperson
* Production_City
* Customer_Rating
* Return_Reason

### 2. customers

Contains customer-related information.

**Columns:**

* Customer_ID
* Customer_Name
* State

### 3. products

Contains product-related information.

**Columns:**

* Product_ID
* Product_Name
* Product_Category

**Columns:**

* Product_ID
* Product_Name
* Product_Category
---

## Project Objectives

* Analyze overall sales performance.
* Measure profitability across regions and products.
* Identify top customers and products.
* Evaluate customer purchasing behavior.
* Analyze returned orders and loss-making transactions.
* Practice advanced SQL querying techniques.

---

## SQL Concepts Used

### Basic SQL

* SELECT
* WHERE
* ORDER BY
* LIMIT

### Aggregate Functions

* COUNT()
* SUM()
* AVG()
* MAX()
* MIN()

### Grouping

* GROUP BY
* HAVING

### Filtering Operators

* IN
* BETWEEN
* AND
* OR

### Joins

* INNER JOIN
* LEFT JOIN

### Window Functions

* RANK()
* DENSE_RANK()
* PARTITION BY
* Running Total

### Subqueries

* Scalar Subqueries
* Correlated Subqueries

### Common Table Expressions (CTE)

* Customer Sales Analysis
* Top Customer Analysis

### Conditional Statements

* CASE WHEN

### Performance Optimization

* INDEX

---

## Analysis Performed

### KPI Analysis

* Total Orders
* Total Customers
* Total Products
* Total Sales
* Total Cost
* Total Profit

### Sales Analysis

* Sales by Region
* Sales by State
* Sales by Product
* Sales by Product Category
* Monthly Sales Trends

### Profit Analysis

* Profit by Region
* Profit by City
* Profit by Product
* High and Low Profit Regions

### Customer Analysis

* Customer Ranking by Sales
* Top Customers by Revenue
* Customers Above Average Sales

### Product Analysis

* Product Ranking by Quantity Sold
* Product Profitability Analysis
* Category-wise Performance

### Order Analysis

* Returned Orders
* Negative Profit Orders
* Payment Mode Analysis
* Sales Channel Analysis

---

## Sample Business Questions Solved

1. What is the total revenue generated?
2. Which region generates the highest profit?
3. Who are the top customers by sales value?
4. Which products generate the most profit?
5. Which cities contribute the highest revenue?
6. How many orders are returned?
7. Which orders result in losses?
8. What are the monthly sales trends?
9. Which customers spend above average?
10. Which product categories perform best?

---

## Query Optimization

Indexes were created on frequently used columns:

* Order_ID
* Customer_ID
* Product_ID
* Order_Date
* Region
* State
* City
* Salesperson
* Order_Status

These indexes improve query performance for filtering, joining, and reporting operations.

---

## Skills Demonstrated

* Data Analysis using SQL
* Business Problem Solving
* Query Optimization
* Data Aggregation
* Customer Analytics
* Sales Analytics
* Window Functions
* CTEs and Subqueries
* Relational Database Concepts

---

## Future Enhancements

* Build interactive Power BI dashboard.
* Create SQL views for reporting.
* Implement stored procedures.
* Add advanced business KPI tracking.
* Integrate SQL analysis with Python automation.

---

## Author

**Kailash Aanjana**

SQL | Power BI | Excel | Python | Data Analytics
