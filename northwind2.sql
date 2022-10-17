-- Bai tap  not between,  like, not like , right, left, mid, len, is not null, is null, max, min , avg, count, tich(product), orderby, Group by, having
SELECT *
FROM Products 
WHERE ProductName LIKE 'A_%' 

SELECT ProductID, left(ProductName,4) as left4
FROM Products 

SELECT ProductID, SUBSTRING(ProductName,2,4) AS [SubString ProductName]
FROM Products 

SELECT ProductID, LEN(ProductName) AS [length Of ProductName]
FROM Products

SELECT COUNT(*) FROM Products AS [Rows number in Products record]

SELECT SupplierID , AVG(UnitsInstock) as avgUnit FROM Products 
GROUP BY SupplierID  --Dieu kien Group by la trong having
HAVING AVG(UnitsInstock) >= 50


SELECT * 
FROM Suppliers WHERE Fax IS NOT NULL AND HomePage IS NULL

--vidu1: Hien thi bang OrderDetail sap xep theo UnitPrice giam dan
SELECT* FROM [Order Details] ORDER BY UnitPrice desc

--vidu2: Hien thi bang OrderDetail sap xep theo UnitPrice giam dan, neu cung UnitPrice thi Quantity tang dan
SELECT* FROM [Order Details] ORDER BY UnitPrice DESC, Quantity ASC

--vidu3: Hien thi 2 bo co UnitPrice cao nhat
SELECT TOP 2 UnitPrice FROM [Order Details] ORDER BY UnitPrice desc

--vidu4:  Dem so don hang cua tung khach hang
SELECT CustomerID, COUNT(CustomerID) as soluong
FROM Orders
GROUP BY CustomerID


--vidu5: Dem so don hang cua tung khach hang, chi thong ke khach hang co tu 4 don hang tro len
SELECT CustomerID, COUNT(CustomerID) as [soluong>=4]
FROM Orders
GROUP BY CustomerID
HAVING COUNT(CustomerID) >= 4

--vidu6: Lay OrderID, ProductID, Quantity  trong bang Order Details co Unitprice giua 50 vaf 100 va quantity la 20
SELECT OrderID, ProductID, Quantity 
FROM [Order Details] 
WHERE UnitPrice BETWEEN 50 AND 100 AND Quantity = 20

--vidu7": Lay gia trung binh cua tat ca cac mat hang (Unitprice trong bang Order Details)
SELECT ProductID, AVG(UnitPrice) AS [avg Price Of Each Product], SUM(UnitPrice) AS [sum of each Product], Count(UnitPrice) AS [price for this product]
FROM [Order Details]
GROUP BY ProductID

--vidu8: Lay thong tin OrderID, CustomerID, Orderdate trong thang 7 nam 1996 
SELECT OrderID,CustomerID,OrderDate
FROM Orders  
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31'

--1.Hien thi cac cot: CategoryId, CategoryName và Description trong table Categories theo chieu giam dan cua CategoryName
SELECT  CategoryID, CategoryName, Description
FROM Categories
ORDER BY CategoryName DESC


--2. Hay liet ke ten cac thanh pho (City) trong bang Customers voi thong tin khong trung lap (su dung DISTINCT)
SELECT DISTINCT City FROM Customers
SELECT City, COUNT(City) AS [The number of people] FROM Customers
GROUP BY City
HAVING COUNT(City) > 1

--3. Trong table Products, hay hien thi 3 cot ProductName, UnitPrice va UnitsInStock dong thoi sap xep 2 cot nay theo chieu giam dan
SELECT ProductName, UnitPrice, UnitsInStock
FROM Products
ORDER BY UnitPrice DESC, UnitsInStock DESC

--4. Trong table Orders chi hien thi nhung record co cot Freight duoi 50
SELECT 
*FROM Orders
WHERE Freight < 50

--5. Hay hien thi nhung nhan vien (employee) thuoc thanh pho "London" trong bang Employees
SELECT *FROM Employees WHERE City = 'London'

--6. Hay hien thi nhung nhan vien (employee) co FirstName bat dau bang ky tu "A" trong bang Employees
SELECT *FROM Employees WHERE FirstName LIKE 'A%' 

--7. Trong table Employees, hay liet le nhung nhan vien co nam sinh trong khoang tu 1950 den 1960
SELECT *FROM Employees WHERE BirthDate BETWEEN '1950-01-01' AND '1960-12-31' 

--8. Trong table Shippers hay liet ke cac CompanyName va so Phone voi dieu kien Phone khong hien thi ma vung(lay 7 so cuoi)

SELECT CompanyName, RIGHT(PHONE,8), Phone
FROM Shippers

--9. Hay tim nhan vien co HOmephone ma 4 so cuoi la 4444
SELECT *FROM Employees WHERE HomePhone LIKE '%4444'
 
--10. Hay tim nhung nhan vien o thanh pho 'Tacoma' hoac Seattle'
SELECT *FROM Employees WHERE City IN('Tacoma', 'Seattle') --The IN operator allows you to specify multiple values in a WHERE clause.

                                                          --The IN operator is a shorthand for multiple OR conditions.

--11. Hay hien thi nhung nhan vien co TitleOfCourtesy la 'Mr' hoac 'Ms'
SELECT *FROM Employees WHERE TitleOfCourtesy IN('Mr.', 'Ms.')

--12. Trong table Suppliers, hay hien thi nhung record cos so Fax (khong null) va co SupplierID tu 5 toi 20
SELECT 
*FROM Suppliers
WHERE Fax IS NOT NULL AND SupplierID BETWEEN 5 AND 20
--#IS NULL 

--13. Hay hien thi cac Supplier co Country la Germany hoac Australia hoac Denmark
SELECT 
*FROM Suppliers
WHERE Country IN('Germany', 'Australia', 'Denmark')
--14. Trong table Suppliers, hay hien thi cac record co SupplierID tu 5 den 20 va khong thuoc Country 'Brazil'
SELECT 
*FROM Suppliers
WHERE NOT Country = 'Brazil' AND SupplierID BETWEEN 5 AND 20

--15. Hien thi thong tin trong table Suppliers tru nhung SupplierID tu 10 den 20
SELECT 
*FROM Suppliers
WHERE NOT SupplierID BETWEEN 10 AND 20

--16. Dung table Products de dua ra nhung san pham co UnitPrice <20 va UnitInStock>30
SELECT 
*FROM Products
WHERE UnitPrice < 20 AND UnitsInStock > 30

--17. Hien thi tat ca cac san pham trong table Products thuoc CategoryID la '1' va tru san pham co ten la 'Chang'
SELECT 
*FROM Products
WHERE CategoryID = 1 AND NOT ProductName = 'Chang'

--18. Liet ke nhung Product thuoc CategoryName la 'Seafood'
SELECT 
*FROM Categories
WHERE CategoryName = 'Seafood'

--19. Hien thi: ProductID, ProductName, QuantityPerUnit vaf UnitsInStock cua nuhng san pham thuoc loai 'Confections' va co QunatityPerUnit chua chuoi 'boxes' hoac bags
SELECT ProductID, ProductName, QuantityPerUnit, UnitsInStock, CategoryName
FROM Products JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Confections'

--20 Hay tim nhung ten san pham chua chuoi 'Chef' trong table Products
SELECT 
*FROM Products 
WHERE CHARINDEX('Chef',ProductName) > 0

--21. Tim san pham co ten bat dau la 'Queso' va ket thuc la chuoi 'Pastora' trong table Products
SELECT 
*FROM Products 
--WHERE ProductName LIKE 'Queso%' AND  ProductName LIKE '%Pastora'
WHERE ProductName LIKE 'Queso%%Pastora'

--22. Hay dem co bao nhieu Territory thuoc tung Region
SELECT RegionDescription, COUNT(TerritoryDescription) AS Quantity
FROM Territories JOIN Region ON Territories.RegionID = Region.RegionID
GROUP BY RegionDescription


--23. Trong table Customers hay cho biet co bao nhieu customers khong co so fax
SELECT COUNT(CustomerID)
FROM Customers
WHERE Fax IS NULL
--24. Tim trong table Customers nhung CompanyName co chieu dai duoi 10 ki tu
SELECT CompanyName
FROM Customers
WHERE LEN(CompanyName) < 10

--25. Trong table Order Details, hay thong ke UnitPrice lon nhat va Quantity lon nhat
SELECT MAX(UnitPrice) AS UnitMax, MAX(Quantity) AS QuanMax
FROM [Order Details]

--26. Trong table Order Details, hay thong ke UnitPrice lon nhat va Quantity theo tung ProducID
SELECT ProductID, MAX(UnitPrice*Quantity) AS Money
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID

--27. Tinh gia tri trung binh cua cot UnitPrice trong table Order Details
SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM [Order Details]


--28. Tim nhung Quantity cao nhat trong table Order Details tren ProductName
SELECT ProductName, MAX(Quantity) AS MaxQuantity
FROM [Order Details] o1, Products o2 WHERE o1.ProductID = o2.ProductID
GROUP BY ProductName



--29. Hien thi cot CategoryID va UnitsInStock cua nhung UnitsInstock nho nhat trong table Products
SELECT CategoryID, UnitsInStock
FROM Products
WHERE UnitsInStock = (SELECT MIN(UnitsInStock) FROM Products)



--30. Hay hien thi nhung gia tri trung binh cua UnitPrice theo CategoryID va chi hien thi nhung gia tri trung binh trong khoang tu 20 den 30
SELECT CategoryID, AVG(UnitPrice)
FROM Products
GROUP BY CategoryID
HAVING AVG(UnitPrice) BETWEEN 20 AND 30


