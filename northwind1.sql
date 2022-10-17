--vd1: Danh sách ID, Fullname, Country
select * from Employees 
select EmployeeID, LastName + ' ' + FirstName as [FullName], Country, year(getdate()) - year(BirthDate) as [Age]
from Employees 
where year(getdate()) - year(BirthDate) >= 70 AND Country = 'USA'
ORDER BY Age DESC
select Top(3)  EmployeeID, LastName  from Employees 
--Vd4
Select CustomerID, CompanyName, ContactName, ContactTitle, Country  from Customers where Country = 'UK'
--Vd5
Select CustomerID, CompanyName, Address, city, country from Customers where Country = 'Mexico'
--Vd6
Select CustomerID , CompanyName , phone, address, city, Country from Customers where Country = 'Sweden'
--vd7
Select ProductID , ProductName , UnitPrice , UnitsInStock  from Products where UnitsInStock between 5 and 10
--vd8
Select *from Products where UnitsOnOrder between 60 and 100

SELECT EmployeeID, count(EmployeeID) FROM Orders GROUP BY YEAR(OrderDate) 
--vd9
SELECT EmployeeID, LastName, FirstName, Title, YEAR(BirthDate), [total orders]
FROM Employees



--Declare syntax
DECLARE @MaxUnitstock AS int 
SET @MaxUnitstock = (SELECT MAX(UnitsInStock) FROM Products)
PRINT @MaxUnitstock

--vd32
SELECT ProductID, ProductName, SupplierID, CategoryID, UnitsInStock 
FROM Products  
WHERE UnitsInStock = @MaxUnitstock --Ko dung duoc???

DECLARE @MinUS AS int = (SELECT MIN(UnitsInStock) FROM Products)
PRINT @MinUS
--vd33
SELECT ProductID, ProductName, SupplierID, CategoryID, UnitsInStock
FROM Products 
WHERE UnitsInStock = @MinUS  --Ko dung duoc ???

--vd34
SELECT ProductID, ProductName, SupplierID, CategoryID, UnitsOnOrder
FROM Products
WHERE UnitsOnOrder = (SELECT MAX(UnitsOnOrder) FROM Products)

--vd35
SELECT ProductID, ProductName, SupplierID, CategoryID, ReorderLevel 
FROM Products
WHERE ReorderLevel = (SELECT MAX(ReorderLevel) FROM Products)

