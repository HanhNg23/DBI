--joins, products


--vidu 1. Lay ten Khach hang va orderID cua khach hang do


--vidu 2. Lay ten cong ty khach hang  va tong soDH cua moi khach hang 

--vidu 3. Hay lay thong tin tat ca khach hang va don hang cua khach hang neu co

--vidu 4. It returns  ProductName, Companyname and categoryname for each product.


--1 Lay ten san pham, so luong da dat cua tung san pham


--2 Lay thong tin Don hang cua cac khach hang dang song tai Torino
SELECT* 
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Torino'

--3. Lay ten KH, ten SP ma khach hang da mua tren 2 lan
SELECT o.CustomerID, COUNT(o.OrderID) AS QuantityBuy, p.ProductName
FROM Orders o 
JOIN [Order Details] ode ON o.OrderID = ode.OrderID 
JOIN Products p ON ode.ProductID = p.ProductID
GROUP BY o.CustomerID, p.ProductName
HAVING COUNT(o.OrderID) > 2

SELECT o.CustomerID, COUNT(o.OrderID) AS QuantityBuy
FROM Orders o 
GROUP BY o.CustomerID
HAVING COUNT(o.OrderID) > 2

--9. Write a SELECT query to display total orders of every employee in 1996 as following:
SELECT EmployeeID, COUNT(OrderID)
FROM Orders
WHERE YEAR(OrderDate) = 1996
GROUP BY EmployeeID

--10. Write a SELECT query to display total orders of every employee in 1998 as following:
SELECT EmployeeID, COUNT(OrderID)
FROM Orders
WHERE YEAR(OrderDate) = 1998
GROUP BY EmployeeID

--11. Write a SELECT query to display total orders of every employee from 1/1/1998 to 31/7/1998 as following:
SELECT o.EmployeeID, COUNT(o.OrderID)
FROM Orders o
WHERE OrderDate BETWEEN '1998-01-01' AND '1998-07-31'
GROUP BY o.EmployeeID

--12. Write a SELECT query to display total orders of every employee from 1/1/1997 to 30/6/1997 as following:
SELECT e.EmployeeID, e.FirstName, COUNT(o.OrderID)
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE OrderDate BETWEEN '1998-01-01' AND '1998-07-31'
GROUP BY e.EmployeeID, e.FirstName

--18. Liet ke ProductID, ProductName, CategoryName nhung Product thuoc CategoryName la 'Seafood'
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Seafood'


--28. Tim nhung Quantity cao nhat trong table Order Details tren ProductName
SELECT*
FROM [Order Details] o , Products p
WHERE o.ProductID = o.ProductID AND o.Quantity = (SELECT MAX(Quantity) FROM [Order Details])








