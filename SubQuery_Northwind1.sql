--1.UNION, INTERSECT, EXCEPT
--UNION The following SQL statement returns the German cities (only distinct values) 
--from both the "Customers" and the "Suppliers" table
SELECT City FROM Customers WHERE Country ='Germany'
UNION
SELECT City FROM Suppliers WHERE Country ='Germany'

-- INTERSECT
SELECT City FROM Customers WHERE Country ='Germany'
INTERSECT
SELECT City FROM Suppliers WHERE Country ='Germany'


--EXCEPT
SELECT City FROM Customers WHERE Country ='Germany'
EXCEPT
SELECT City FROM Suppliers WHERE Country ='Germany'


-- ÔN TẬP: 
--1. Liệt kê các đơn hàng có trọng lượng từ 100 đến 500
SELECT*
FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT*
FROM Orders
WHERE Freight >=100 AND Freight<=500

--2. Liệt kê các đơn hàng gửi tới Mexico, Brazil, Mĩ
SELECT*
FROM Orders
WHERE ShipCountry='Mexico' OR ShipCountry LIKE 'Brazil' OR ShipCountry ='USA'

SELECT*
FROM Orders
WHERE ShipCountry IN('Mexico','Brazil','USA')

--3. Liệt kê các đơn hàng không gửi tới Mexico, Brazil, Mĩ
SELECT*
FROM Orders
WHERE ShipCountry NOT IN('Mexico','Brazil','USA')

--4. Liệt kê các đơn hàng năm 1996 ngoại trừ tháng 1 2 3 (quy I) 
-- TOÁN TỬ IN dùng cho tập rời rạc
SELECT*
FROM Orders
WHERE year(OrderDate)=1996 AND month(OrderDate) NOT IN (1,2,3)

--5. Liệt kê các khách hàng từ Mỹ và Brazil có số fax và Region
SELECT*
FROM Customers
WHERE Country IN ('USA','Brazil') AND Fax IS NOT NULL AND Region IS NOT NULL

--6. Nhân viên có tên(first name) gồm 5 kí tự
SELECT*
FROM Employees
WHERE LEN(FirstName)=5

SELECT*
FROM Employees
WHERE FirstName LIKE 'L____'
	

-- SUB QUERY

--1. In ra danh sách nhân viên
SELECT *FROM Employees


--2 Liệt kê các nhân viên có cùng City với Michael
SELECT *FROM Employees WHERE City =
		(SELECT City FROM Employees WHERE FirstName='Michael')
		AND FirstName <>'Michael'

--2 Liệt kê các đơn hàng có trọng lượng lớn hơn hay bằng đơn hàng 10623 
--và không bao gồm đơn hàng 10623
SELECT *
FROM Orders
WHERE Freight>=(
			SELECT Freight
			FROM Orders
			WHERE OrderID='10623') AND OrderID<>'10623'
--BTVN
--1. Liệt kê danh sách các công ty vận chuyển hàng

--2. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có mã số 1.

--3. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có tên Speedy Express.

--4. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận 
--có tên Speedy Express và trọng lượng từ 100 đến 250.

--5. Liệt kê các mặt hàng cùng chủng loại với mặt hàng Filo Mix


--6. Liệt kê các nhân viên lớn tuổi hơn nhân viên Janet.


-- Hoàn thành Northwind1+ Northwind2+ lab4+lab3