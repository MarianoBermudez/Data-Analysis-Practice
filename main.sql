-- All the tables
SELECT * FROM Customer
SELECT * FROM "Order"
SELECT * FROM OrderItem
SELECT * FROM Product
SELECT * FROM Supplier;


-- Count of customers by country
SELECT TOP 10 Country, COUNT(Id) AS 'Count of customers by country'
FROM Customer
GROUP BY Country
ORDER BY COUNT(Id) DESC;


-- Customers who made orders of more than $10,000
SELECT DISTINCT FirstName, LastName
FROM Customer
WHERE Id IN (
	SELECT CustomerId
	FROM "Order"
	WHERE TotalAmount > 10000);


-- Total by product
SELECT ProductName, SUM(ord.UnitPrice * ord.Quantity) AS Total
FROM OrderItem ord
JOIN Product ON ord.ProductId = Product.Id
GROUP BY ProductName


-- Amount of orders by country
SELECT Country, COUNT(ord.Id) AS 'Amount of orders'
FROM "Order" ord
JOIN CUSTOMER cus ON cus.Id = ord.CustomerId
GROUP BY Country
ORDER BY COUNT(ord.Id) DESC;


-- Suppliers ordered by total
SELECT 
    s.CompanyName,
    CONCAT('$', SUM(oi.UnitPrice * oi.Quantity)) AS Total
FROM 
    Supplier s
    JOIN Product p ON s.Id = p.SupplierId
    JOIN OrderItem oi ON p.Id = oi.ProductId
GROUP BY s.CompanyName
ORDER BY Total DESC;


-- Orders with more than 5 different products
SELECT OrderId, COUNT(Id) AS 'Amount of different products'
FROM OrderItem
GROUP BY OrderId
HAVING COUNT(Id) > 5


--Customers with an average of more than 2000 by order
SELECT FirstName, LastName, AVG(TotalAmount) AS 'Average'
FROM "Order"
JOIN Customer ON CustomerId = Customer.Id
GROUP BY FirstName, LastName
HAVING AVG(TotalAmount) > 2000
ORDER BY AVG(TotalAmount) DESC