--Question 1
CREATE TABLE ProductPriceHistory(
ProductID char(10),
StartDate date,
EndDate date,
Price int,
FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
CONSTRAINT PK PRIMARY KEY (ProductID, StartDate)
)


CREATE TABLE Product(
ProductID char(10) Primary Key,
Name nvarchar(15),
Color varchar(15),
Cost int,
Price int,
SubcategoryID char(10),
ModelID char(10),
SellStartDate date,
SellEndDate date
)

CREATE TABLE ProductCostHistory(

)


--Question 2
SELECT *FROM Employees WHERE Salary > 9000

--Question 3
SELECT DISTINCT j.JobID, j.JobTitle, j.min_salary
FROM Jobs j
WHERE J.JobTitle LIKE '%Manager%' 
AND min_salary > 5000
ORDER BY min_salary DESC

--Question 4
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary,d.DepartmentName, l.StateProvince, l.CountryID
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Locations l ON d.LocationID = l.LocationID
WHERE e.Salary > 3000 AND l.StateProvince = 'Washington' AND l.CountryID = 'US'

--Question 5
SELECT l.LocationID, L.StreetAddress, l.City, l.StateProvince, l.CountryID, COUNT(DepartmentID) AS Numberofdepartment
FROM Locations l
LEFT JOIN Departments d ON l.LocationID = d.LocationID
GROUP BY l.LocationID, L.StreetAddress, l.City, l.StateProvince, l.CountryID
ORDER BY Numberofdepartment DESC

--Question 6
SELECT TOP(1) j.JobID, j.JobTitle, COUNT(e.EmployeeID) AS NumberOfEmployees
FROM Jobs j
JOIN Employees e ON j.JobID = e.JobID 
GROUP BY j.JobID, j.JobTitle
ORDER BY NumberOfEmployees DESC

--Question 7 
SELECT e.EmployeeID, e.LastName, e.FirstName, e.Salary, d.DepartmentName INTO PartI
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
--------------------------------------------------------------------------------------
SELECT DISTINCT e.ManagerID, COUNT(e.EmployeeID) AS NumberOfSubordinates INTO PartII
FROM Employees e
GROUP BY e.ManagerID
HAVING e.ManagerID IS NOT NULL
--------------------------------------------------------------------------------------
SELECT * FROM PartI
SELECT * FROM PartII
--------------------------------------------------------------------------------------
SELECT * INTO RESULT7
FROM PartI
LEFT JOIN PartII ON PartI.EmployeeID = PartII.ManagerID
WHERE PartII.NumberOfSubordinates IS NOT NULL OR PartI.Salary > 10000
ORDER BY PartII.NumberOfSubordinates DESC
--------------------------------------------------------------------------------------
UPDATE RESULT7 
SET ManagerID = 0 ,
NumberOfSubordinates = 0
WHERE ManagerID IS NULL OR NumberOfSubordinates IS NULL
--------------------------------------------------------------------------------------
SELECT * FROM RESULT7

--Question 8 ko co
--Question 9 ko co

--Question 10
SELECT d.DepartmentID, d.DepartmentName, d.ManagerID, d.LocationID , COUNT(e.EmployeeID) AS NumofEmployees INTO RESULT10
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName, d.ManagerID, d.LocationID


ALTER TABLE RESULT10
DROP COLUMN NumofEmployees

SELECT * FROM RESULT10






