# Sales Analysis Project Using SQL

USE sales_project;

-- =====================================================
-- SECTION 1: BASIC KPI ANALYSIS
-- =====================================================

-- Q1. Count Total Orders
SELECT COUNT(*) AS total_orders
FROM mainsales2;

-- Q2. Count Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q3. Count Total Products
SELECT COUNT(*) AS total_products
FROM products;

-- Q4. Calculate Total Sales
SELECT SUM(Total_Sales) AS total_sales
FROM mainsales2;

-- Q5. Calculate Total Profit
SELECT SUM(Profit) AS total_profit
FROM mainsales2;

-- Q6. Calculate Total Cost
SELECT SUM(Total_Cost) AS total_cost
FROM mainsales2;

-- =====================================================
-- SECTION 2: FILTERING & CONDITIONAL ANALYSIS
-- =====================================================

-- Q7. Find Orders with Negative Profit
SELECT *
FROM mainsales2
WHERE Profit < 0;

-- Q8. Count Loss Orders
SELECT COUNT(*) AS loss_orders
FROM mainsales2
WHERE Profit < 0;

-- Q9. Find Orders with Marketing Cost Greater Than 500
SELECT *
FROM mainsales2
WHERE Marketing_Cost > 500;

-- Q10. Find Orders with Discount Above 20%
SELECT *
FROM mainsales2
WHERE Discount_Percent > 20;

-- Q11. Show Returned Orders
SELECT *
FROM mainsales2
WHERE Order_Status = 'Returned';

-- Q12. Show COD Orders
SELECT *
FROM mainsales2
WHERE Payment_Mode = 'COD';

-- Q13. Show Online Orders
SELECT *
FROM mainsales2
WHERE Sales_Channel = 'Online';

-- =====================================================
-- SECTION 3: GROUP BY ANALYSIS
-- =====================================================

-- Q14. Total Sales by Region
SELECT Region,
SUM(Total_Sales) AS Total_Sales
FROM mainsales2
GROUP BY Region;

-- Q15. Total Profit by Region
SELECT Region,
SUM(Profit) AS Total_Profit
FROM mainsales2
GROUP BY Region;

-- Q16. Total Sales by State
SELECT State,
SUM(Total_Sales) AS Total_Sales
FROM mainsales2
GROUP BY State;

-- Q17. Total Profit by City
SELECT City,
SUM(Profit) AS Total_Profit
FROM mainsales2
GROUP BY City;

-- Q18. Total Quantity Sold by Product
SELECT Product_ID,
SUM(Quantity) AS Total_Quantity
FROM mainsales2
GROUP BY Product_ID;

-- =====================================================
-- SECTION 4: JOINS
-- =====================================================

-- Q19. Order Details with Customer Name
SELECT
c.Customer_Name,
ms.Order_ID,
ms.Order_Date,
ms.Total_Sales,
ms.Profit
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID;

-- Q20. Order Details with Product Name
SELECT
p.Product_Name,
ms.Order_ID,
ms.Total_Sales,
ms.Profit
FROM mainsales2 ms
JOIN products p
ON ms.Product_ID = p.Product_ID;

-- Q21. Customer Name + Product Name + Order Details
SELECT
c.Customer_Name,
p.Product_Name,
ms.Order_ID,
ms.Total_Sales,
ms.Profit
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
JOIN products p
ON ms.Product_ID = p.Product_ID;

-- =====================================================
-- SECTION 5: TOP N ANALYSIS
-- =====================================================

-- Q22. Top 3 Customers by Purchase Value
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Purchase
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Purchase DESC
LIMIT 3;

-- Q23. Top 5 Cities by Profit
SELECT
City,
SUM(Profit) AS Total_Profit
FROM mainsales2
GROUP BY City
ORDER BY Total_Profit DESC
LIMIT 5;

-- =====================================================
-- SECTION 6: WINDOW FUNCTIONS
-- =====================================================

-- Q24. Rank Customers by Total Sales
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Sales,
DENSE_RANK() OVER(
ORDER BY SUM(ms.Total_Sales) DESC
) AS Ranking
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name;

-- Q25. Rank Products by Quantity Sold
SELECT
p.Product_Name,
SUM(ms.Quantity) AS Total_Qty,
DENSE_RANK() OVER(
ORDER BY SUM(ms.Quantity) DESC
) AS Ranking
FROM mainsales2 ms
JOIN products p
ON ms.Product_ID = p.Product_ID
GROUP BY p.Product_Name;

-- Q26. Running Total Sales
SELECT
Order_Date,
Total_Sales,
SUM(Total_Sales)
OVER(ORDER BY Order_Date)
AS Running_Total
FROM mainsales2;

-- =====================================================
-- SECTION 7: CASE STATEMENTS
-- =====================================================

-- Q27. Sales Category Classification
SELECT
Customer_ID,
Total_Sales,
CASE
WHEN Total_Sales > 100000 THEN 'High Sales'
WHEN Total_Sales > 50000 THEN 'Medium Sales'
WHEN Total_Sales > 10000 THEN 'Low Sales'
ELSE 'Very Low Sales'
END AS Sales_Category
FROM mainsales2;

-- Q28. Profit Status by Region
SELECT
Region,
SUM(Profit) AS Total_Profit,
CASE
WHEN SUM(Profit) >= 50000 THEN 'High Profit'
WHEN SUM(Profit) >= 20000 THEN 'Medium Profit'
ELSE 'Low Profit'
END AS Profit_Category
FROM mainsales2
GROUP BY Region;

-- =====================================================
-- SECTION 8: SUBQUERIES
-- =====================================================

-- Q29. Orders Above Average Sales
SELECT
Order_ID,
Total_Sales
FROM mainsales2
WHERE Total_Sales >
(
SELECT AVG(Total_Sales)
FROM mainsales2
);

-- Q30. Customers Whose Sales Are Higher Than Their City's Average
SELECT
c.Customer_Name,
ms.City,
ms.Total_Sales
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
WHERE ms.Total_Sales >
(
SELECT AVG(m2.Total_Sales)
FROM mainsales2 m2
WHERE m2.City = ms.City
);

-- =====================================================
-- SECTION 9: CTE (COMMON TABLE EXPRESSIONS)
-- =====================================================

-- Q31. Customers with Sales Above 200000
WITH SalesCTE AS
(
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Sales
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
)
SELECT *
FROM SalesCTE
WHERE Total_Sales > 200000;

-- Q32. Top 10 Customers by Sales
WITH TopTenCTE AS
(
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Sales
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
)
SELECT *
FROM TopTenCTE
ORDER BY Total_Sales DESC
LIMIT 10;

-- =====================================================
-- SECTION 10: INDEXING
-- =====================================================

CREATE INDEX idx_order_id
ON mainsales2(Order_ID);

CREATE INDEX idx_customer_id
ON mainsales2(Customer_ID);

CREATE INDEX idx_product_id
ON mainsales2(Product_ID);

CREATE INDEX idx_order_date
ON mainsales2(Order_Date);

CREATE INDEX idx_region
ON mainsales2(Region);

CREATE INDEX idx_state
ON mainsales2(State);

CREATE INDEX idx_city
ON mainsales2(City);

CREATE INDEX idx_salesperson
ON mainsales2(Salesperson);

CREATE INDEX idx_order_status
ON mainsales2(Order_Status);
# Sales Analysis Project Using SQL

USE sales_project;

-- =====================================================
-- SECTION 1: BASIC KPI ANALYSIS
-- =====================================================

-- Q1. Count Total Orders
SELECT COUNT(*) AS total_orders
FROM mainsales2;

-- Q2. Count Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q3. Count Total Products
SELECT COUNT(*) AS total_products
FROM products;

-- Q4. Calculate Total Sales
SELECT SUM(Total_Sales) AS total_sales
FROM mainsales2;

-- Q5. Calculate Total Profit
SELECT SUM(Profit) AS total_profit
FROM mainsales2;

-- Q6. Calculate Total Cost
SELECT SUM(Total_Cost) AS total_cost
FROM mainsales2;

-- =====================================================
-- SECTION 2: FILTERING & CONDITIONAL ANALYSIS
-- =====================================================

-- Q7. Find Orders with Negative Profit
SELECT *
FROM mainsales2
WHERE Profit < 0;

-- Q8. Count Loss Orders
SELECT COUNT(*) AS loss_orders
FROM mainsales2
WHERE Profit < 0;

-- Q9. Find Orders with Marketing Cost Greater Than 500
SELECT *
FROM mainsales2
WHERE Marketing_Cost > 500;

-- Q10. Find Orders with Discount Above 20%
SELECT *
FROM mainsales2
WHERE Discount_Percent > 20;

-- Q11. Show Returned Orders
SELECT *
FROM mainsales2
WHERE Order_Status = 'Returned';

-- Q12. Show COD Orders
SELECT *
FROM mainsales2
WHERE Payment_Mode = 'COD';

-- Q13. Show Online Orders
SELECT *
FROM mainsales2
WHERE Sales_Channel = 'Online';

-- =====================================================
-- SECTION 3: GROUP BY ANALYSIS
-- =====================================================

-- Q14. Total Sales by Region
SELECT Region,
SUM(Total_Sales) AS Total_Sales
FROM mainsales2
GROUP BY Region;

-- Q15. Total Profit by Region
SELECT Region,
SUM(Profit) AS Total_Profit
FROM mainsales2
GROUP BY Region;

-- Q16. Total Sales by State
SELECT State,
SUM(Total_Sales) AS Total_Sales
FROM mainsales2
GROUP BY State;

-- Q17. Total Profit by City
SELECT City,
SUM(Profit) AS Total_Profit
FROM mainsales2
GROUP BY City;

-- Q18. Total Quantity Sold by Product
SELECT Product_ID,
SUM(Quantity) AS Total_Quantity
FROM mainsales2
GROUP BY Product_ID;

-- =====================================================
-- SECTION 4: JOINS
-- =====================================================

-- Q19. Order Details with Customer Name
SELECT
c.Customer_Name,
ms.Order_ID,
ms.Order_Date,
ms.Total_Sales,
ms.Profit
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID;

-- Q20. Order Details with Product Name
SELECT
p.Product_Name,
ms.Order_ID,
ms.Total_Sales,
ms.Profit
FROM mainsales2 ms
JOIN products p
ON ms.Product_ID = p.Product_ID;

-- Q21. Customer Name + Product Name + Order Details
SELECT
c.Customer_Name,
p.Product_Name,
ms.Order_ID,
ms.Total_Sales,
ms.Profit
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
JOIN products p
ON ms.Product_ID = p.Product_ID;

-- =====================================================
-- SECTION 5: TOP N ANALYSIS
-- =====================================================

-- Q22. Top 3 Customers by Purchase Value
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Purchase
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Purchase DESC
LIMIT 3;

-- Q23. Top 5 Cities by Profit
SELECT
City,
SUM(Profit) AS Total_Profit
FROM mainsales2
GROUP BY City
ORDER BY Total_Profit DESC
LIMIT 5;

-- =====================================================
-- SECTION 6: WINDOW FUNCTIONS
-- =====================================================

-- Q24. Rank Customers by Total Sales
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Sales,
DENSE_RANK() OVER(
ORDER BY SUM(ms.Total_Sales) DESC
) AS Ranking
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name;

-- Q25. Rank Products by Quantity Sold
SELECT
p.Product_Name,
SUM(ms.Quantity) AS Total_Qty,
DENSE_RANK() OVER(
ORDER BY SUM(ms.Quantity) DESC
) AS Ranking
FROM mainsales2 ms
JOIN products p
ON ms.Product_ID = p.Product_ID
GROUP BY p.Product_Name;

-- Q26. Running Total Sales
SELECT
Order_Date,
Total_Sales,
SUM(Total_Sales)
OVER(ORDER BY Order_Date)
AS Running_Total
FROM mainsales2;

-- =====================================================
-- SECTION 7: CASE STATEMENTS
-- =====================================================

-- Q27. Sales Category Classification
SELECT
Customer_ID,
Total_Sales,
CASE
WHEN Total_Sales > 100000 THEN 'High Sales'
WHEN Total_Sales > 50000 THEN 'Medium Sales'
WHEN Total_Sales > 10000 THEN 'Low Sales'
ELSE 'Very Low Sales'
END AS Sales_Category
FROM mainsales2;

-- Q28. Profit Status by Region
SELECT
Region,
SUM(Profit) AS Total_Profit,
CASE
WHEN SUM(Profit) >= 50000 THEN 'High Profit'
WHEN SUM(Profit) >= 20000 THEN 'Medium Profit'
ELSE 'Low Profit'
END AS Profit_Category
FROM mainsales2
GROUP BY Region;

-- =====================================================
-- SECTION 8: SUBQUERIES
-- =====================================================

-- Q29. Orders Above Average Sales
SELECT
Order_ID,
Total_Sales
FROM mainsales2
WHERE Total_Sales >
(
SELECT AVG(Total_Sales)
FROM mainsales2
);

-- Q30. Customers Whose Sales Are Higher Than Their City's Average
SELECT
c.Customer_Name,
ms.City,
ms.Total_Sales
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
WHERE ms.Total_Sales >
(
SELECT AVG(m2.Total_Sales)
FROM mainsales2 m2
WHERE m2.City = ms.City
);

-- =====================================================
-- SECTION 9: CTE (COMMON TABLE EXPRESSIONS)
-- =====================================================

-- Q31. Customers with Sales Above 200000
WITH SalesCTE AS
(
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Sales
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
)
SELECT *
FROM SalesCTE
WHERE Total_Sales > 200000;

-- Q32. Top 10 Customers by Sales
WITH TopTenCTE AS
(
SELECT
c.Customer_Name,
SUM(ms.Total_Sales) AS Total_Sales
FROM mainsales2 ms
JOIN customers c
ON ms.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
)
SELECT *
FROM TopTenCTE
ORDER BY Total_Sales DESC
LIMIT 10;

-- =====================================================
-- SECTION 10: INDEXING
-- =====================================================

CREATE INDEX idx_order_id
ON mainsales2(Order_ID);

CREATE INDEX idx_customer_id
ON mainsales2(Customer_ID);

CREATE INDEX idx_product_id
ON mainsales2(Product_ID);

CREATE INDEX idx_order_date
ON mainsales2(Order_Date);

CREATE INDEX idx_region
ON mainsales2(Region);

CREATE INDEX idx_state
ON mainsales2(State);

CREATE INDEX idx_city
ON mainsales2(City);

CREATE INDEX idx_salesperson
ON mainsales2(Salesperson);

CREATE INDEX idx_order_status
ON mainsales2(Order_Status);
