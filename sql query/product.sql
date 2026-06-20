CREATE TABLE products (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Product_Name VARCHAR(150),
    Product_Category VARCHAR(100),
    Base_Unit_Price DECIMAL(12,2),
    Base_Unit_Cost DECIMAL(12,2),
    Supplier VARCHAR(100),
    Reorder_Level INT
);