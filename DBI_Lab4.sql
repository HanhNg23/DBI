CREATE DATABASE DBI_LAB4
--Question 1
CREATE TABLE Departments(
     DeptID varchar(4) PRIMARY KEY,
	 Name nvarchar(50) NOT NULL,
	 NoOfStudents int
)

CREATE TABLE Students(
     StudentID varchar(4) PRIMARY KEY,
	 LastName nvarchar(30),
	 FirstName nvarchar(10),
	 Sex varchar(1) CHECK(sex IN ('F','M')),
	 DateOfBirth date,
	 PlaceOfBirth nvarchar(30),
	 DeptID varchar(4),
	 Scholarship float,
	 AverageScore Numeric(4,2)
)
SELECT * FROM Students

CREATE TABLE Courses(
CourseID varchar(4) PRIMARY KEY,
Name nvarchar(35),
Credits tinyint
)

CREATE TABLE Results(
StudentID varchar(4) NOT NULL ,
CourseID varchar(4) NOT NULL,
Yearr int NOT NULL ,
Semester int NOT NULL ,
Mark float(1),
Grade varchar(6),
CONSTRAINT PK_Results PRIMARY KEY(StudentID,CourseID, Yearr, Semester))


INSERT INTO Departments
VALUES
('IS', 'Information Systems', 0),
('NC', 'Network and Communication', 0),
('SE', 'Software Engineering', 0),
('CE', 'Computer Engineering', 0),
('CS', 'Computer Science', 0)

INSERT INTO Students 
VALUES
('S001',N'Lê',N'Kim Lan','F','1990-02-23',N'Hà Nội','IS',130000,0),
('S002',N'Trần',N'Minh Chánh','M','1992-12-24',N'Bình Định','NC',150000,0),
('S003',N'Lê',N'An Tuyết','F','1991-02-21',N'Hải Phòng','IS',170000,0),
('S004',N'Trần',N'Anh Tuấn','M','1993-12-20',N'TpHCM','NC',80000,0),
('S005',N'Trần',N'Thị Mai','F','1991-08-12',N'TpHCM','SE',0,0),
('S006',N'Lê',N'Thị Mo','F','1991-01-02',N'An Giang','IS',0,0),
('S007',N'Nguyễn',N'Kim Thư','F','1990-02-02',N'Hà Nội','SE',180000,0),
('S008',N'Lê',N'Văn Long','M','1992-12-12',N'TpHCM','IS',190000,0)

DELETE FROM Students -- Delete all value exists in Student table

INSERT INTO Courses
VALUES 
('DS01','Database','3'),
('AI01','Artificial Intelligence ','3'),
('CN01','Computer Network ','3'),
('CG01','Computer Graphics ','4'),
('DSA1','Data Structures and Algorithms ','4')

INSERT INTO Results(StudentID, CourseID, Yearr, Semester, Mark)
VALUES
		('S001','DS01','2017','1','3'),
		('S001','DS01','2017','2','6'),
		('S001','AI01','2017','1','4.5'),
		('S001','AI01','2017','2','6'),
		('S001','CN01','2017','3','5'),
		('S002','DS01','2016','1','4.5'),
		('S002','DS01','2017','1','7'),
		('S002','CN01','2016','3','10'),
		('S002','DSA1','2016','3','9'),
		('S003','DS01','2017','1','2'),
		('S003','DS01','2017','3','5'),
		('S003','CN01','2017','2','2.5'),
		('S003','CN01','2017','3','4'),
		('S004','DS01','2017','3','4.5'),
		('S004','DSA1','2018','1','10'),
		('S005','DS01','2017','2','7'),
		('S005','CN01','2017','2','2.5'),
		('S005','CN01','2018','1','5'),
		('S006','AI01','2018','1','6'),
		('S006','CN01','2018','2','10')

--Question 2 Update NoOfStudent of Department without drop column NoOfStudent

--**Save the query table**-- 
SELECT d.DeptID, COUNT(s.StudentID) AS CountStu INTO NewDept 
FROM Students s RIGHT JOIN Departments d ON s.DeptID = d.DeptID
GROUP BY d.DeptID 

SELECT * FROM NewDept

UPDATE Departments
SET NoOfStudents=( 
SELECT CountStu FROM NewDept
WHERE NewDept.DeptID = Departments.DeptID
)
SELECT * FROM Departments

/*Question 3 
- Update Average for each student
- Each Coures - take only the student with highest Mark
Note: AverageScore = the average mark of all the course that the studetn joins*/

----Find the top student of each course---------------------------------------
--Calculate average score of each Student's course
SELECT r.StudentID, r.CourseID, AVG(r.Mark) AS AverageCoure INTO AverageTable
FROM Results r 
GROUP BY r.StudentID,r.CourseID

SELECT * FROM AverageTable

--Find top course's student
SELECT av.StudentID,av.CourseID, av.AverageCoure, 
RANK() OVER 
(PARTITION BY av.CourseID ORDER BY av.AverageCoure DESC) AS RANK
INTO RankBetwCourse
FROM AverageTable av

SELECT * FROM RankBetwCourse WHERE RANK = 1
-------------------------------------------------------------------------------
--Question 4 
-- Update the Grade in Result table

--Method 1----------------------------------------
UPDATE Results
SET Grade = 'Passed' WHERE Mark BETWEEN 5 AND 10
UPDATE Results
SET Grade = 'Failed' WHERE Mark BETWEEN 0 AND 5
SELECT * FROM Results

--reset the column Grade
UPDATE Results 
SET Grade = ''

--Method 2--------------------------------
UPDATE Results
SET Grade = CASE
WHEN Mark BETWEEN 5 AND 10 THEN 'Passed'
WHEN Mark BETWEEN 0 AND 5  THEN 'Failed'
END

SELECT * FROM Results 

--Question 5
/*- List (StudentID, Fullname, DateOfBirth, PlaceOfBirth, DeptID, Scholarship) 
of all students having Scholarship4*/

SELECT StudentID, FirstName + ' ' + LastName AS Fullname, DateOfBirth, PlaceOfBirth, DeptID, Scholarship
FROM Students 
WHERE Scholarship > 0 AND Scholarship < 160000

--Question 6
/*List (DeptID, DepartmentName, StudentID, LastName, FirstName) of all departments
so that we see also departments which have no students*/

SELECT d.DeptID, d.Name, s.StudentID, s.LastName, s.FirstName
FROM Students s RIGHT JOIN Departments d
ON s.DeptID = d.DeptID
ORDER BY d.DeptID, d.Name 

--Question 7
/*List (StudentID, LastName, FirstName, NumberOfCourses) of all students
show the results in ascending order of NumberOfCourses
where NumberOfCourses is the total number of courses studied by each student.*/

--Find NumberOfCourses of each student enrolled in
--Count(Distinct ....) : count without duplicate
SELECT s.StudentID, s.LastName, s.FirstName,COUNT(DISTINCT r.CourseID) AS NumberOfCourses
FROM Students s 
JOIN Results r  ON s.StudentID = r.StudentID
GROUP BY s.StudentID, s.LastName, s.FirstName

--Question 8 SEARCH THE KEY COUNTIF
SELECT d.DeptID, d.Name,
COUNT(CASE WHEN s.Sex = 'F' THEN 1 END) AS NumberOfFemale, 
COUNT(CASE WHEN s.Sex = 'M' THEN 1 END) AS NumberOfMale
FROM Students s 
JOIN Departments d ON s.DeptID = d.DeptID 
GROUP BY d.DeptID, s.Sex, d.Name

--Question 9
--Show the list of student
--in department IS
--having Mark of Database System > student in min score in IS

SELECT DISTINCT s.StudentID, s.LastName, s.FirstName, s.Sex, s.DateOfBirth, s.PlaceOfBirth, s.DeptID
FROM Students s 
JOIN Results r ON s.StudentID = r.StudentID
JOIN Departments d ON d.DeptID = s.DeptID
               WHERE d.Name = 'Information Systems' 
               AND r.Mark > (SELECT MIN(r.Mark) FROM Students s
                             JOIN Results r ON s.StudentID = r.StudentID
                             WHERE r.CourseID = 'DS01' AND s.DeptID = 'IS')

--FIND STUDENT IN IS department and study course DS01 but have the min DBS01 score
SELECT MIN(r.Mark) AS MinDaBas INTO MinDaBas FROM Students s
JOIN Results r ON s.StudentID = r.StudentID
WHERE r.CourseID = 'DS01' AND s.DeptID = 'IS'

--Question 10
SELECT c.CourseID, c.Name, ra.StudentID, s.LastName + ' ' + s.FirstName AS BestStudentFullName
FROM RankBetwCourse ra
JOIN Courses c ON ra.CourseID = c.CourseID
JOIN Students s ON s.StudentID = ra.StudentID
WHERE ra.RANK = 1


































