Q1.
-- Achieving 1NF (First Normal Form)
-- Original table: ProductDetail
-- OrderID | CustomerName | Products
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone

-- Create a new table ProductDetail_1NF to store the 1NF compliant data
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);
INSERT INTO ProductDetail (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Display the transformed table
SELECT * FROM ProductDetail ;


Q2.
-- Question 2: Achieving 2NF (Second Normal Form)
-- Original table: OrderDetails
-- OrderID | CustomerName | Product  | Quantity
-- 101     | John Doe     | Laptop   | 2
-- 101     | John Doe     | Mouse    | 1
-- 102     | Jane Smith   | Tablet   | 3
-- 102     | Jane Smith   | Keyboard | 1
-- 102     | Jane Smith   | Mouse    | 2
-- 103     | Emily Clark  | Phone    | 1

-- Create a table for Customers to remove the partial dependency
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert customer data
INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Create a table for OrderProducts with OrderID and Product as primary key
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Insert order product data
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- Display the transformed tables
SELECT * FROM Customers;
SELECT * FROM OrderProducts;
