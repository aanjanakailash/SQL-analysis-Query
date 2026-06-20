create database sales_project;
use sales_project
CREATE TABLE mainsales (
    Order_ID VARCHAR(20),
    Order_Date DATE,

    Customer_ID VARCHAR(20),
    Segment VARCHAR(50),
    Region VARCHAR(50),
    State VARCHAR(100),
    City VARCHAR(100),

    Product_ID VARCHAR(20),

    Quantity INT,
    Unit_Price DECIMAL(12,2),
    Discount_Percent DECIMAL(5,2),
    Unit_Cost DECIMAL(12,2),
    Shipping_Cost DECIMAL(12,2),
    Marketing_Cost DECIMAL(12,2),

    Total_sales DECIMAL(15,2),
    Total_cost DECIMAL(15,2),
    Profit DECIMAL(15,2),

    Payment_Mode VARCHAR(50),
    Sales_Channel VARCHAR(50),
    Order_Status VARCHAR(50),
    Salesperson VARCHAR(100),
    Production_City VARCHAR(100),
    Customer_Rating DECIMAL(3,1),
    Return_Reason VARCHAR(100),

    CONSTRAINT fk_mainsales_customer
        FOREIGN KEY (Customer_ID)
        REFERENCES customers(Customer_ID),

    CONSTRAINT fk_mainsales_product
        FOREIGN KEY (Product_ID)
        REFERENCES products(Product_ID)
);