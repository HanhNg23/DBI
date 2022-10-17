
--https://www.techonthenet.com/sql/index.php
--1.TAO DATABASE=> Giống như việc tạo ra 1 cái phòng, trong phòng chứa nhiều tủ, 
-- mỗi tủ là 1 table(relation)

--CREATE DATABASE dbname;
CREATE DATABASE employeeManagement;
USE employeeManagement;

--2. TAO TABLE => tạo ra tủ đựng đồ mà mỗi attribute là 1 ngăn tủ
--CREATE TABLE tableName
--   ( fieldname1 datatype [integrity_constraints],
--     fieldname2 datatype [integrity_constraints],
--    ….)
CREATE TABLE employee
	(
		employ_ID char(10),
		lastName nvarchar(20),
		firstName nvarchar (30),
		phone char(12),
		Addr nvarchar (30),
		DOB datetime
	)



SELECT * FROM employee WHERE employ_ID='EM0001'

--3. THEM GIA TRI VAO TABLE => đặt quần áo vào tủ
--INSERT INTO tableName(<listOfFields>)
--VALUES  (<value 1>, ... <value m>)

INSERT INTO employee VALUES ('EM0001',N'Nguyễn',N'Trúc Mai Anh','094646287',N'Đồng Nai','1987-5-10')
	
INSERT INTO employee VALUES ('EM0002',N'Lê',N'Bình','094646287',N'Hồ Chí Minh','1987-5-10'	)
INSERT INTO employee (employ_ID,lastName,firstName,phone) VALUES ('EM0003',N'TRần',N'Dương','098645999')

CREATE TABLE employee1
	(
		employ_ID char(10) PRIMARY KEY ,
		lastName nvarchar(20) NOT NULL,
		firstName nvarchar (30) NOT NULL,
		phone char(12) UNIQUE,
		Addr nvarchar (30) DEFAULT N'Hồ Chí Minh',
		DOB datetime CHECK (YEAR(GETDATE())-YEAR(DOB)>=18)
	)

SELECT * FROM employee1
INSERT INTO employee1 VALUES ('EM0001',N'Lê',N'Hoa','094747482',N'Biên Hòa','1987-5-10',NULL)
INSERT INTO employee1 VALUES ('EM0002',N'Lê',N'B','094747483',N'Biên Hòa','1987-5-10',NULL)
INSERT INTO employee1 (employ_ID,firstName,lastName,phone,DOB)
	VALUES('EM0003',N'Trần',N'Xuân','24824242','1876-4-23')
--4. ADD CAC CONSTRAINS
--ALTER TABLE tablename 
--ADD CONSTRAINT constraintName PRIMARY KEY (<attribute list>);
CREATE TABLE employee4
	(
		employ_ID char(10)  NOT NULL,
		lastName nvarchar(20) NOT NULL,
		firstName nvarchar (30) NOT NULL,
		phone char(12) UNIQUE,
		Addr nvarchar (30) DEFAULT N'Hồ Chí Minh',
		DOB datetime CHECK (YEAR(GETDATE())-YEAR(DOB)>=18),
		Depart_ID char(10)
	)



CREATE TABLE employee5
	(
		employ_ID char(10)  NOT NULL,
		lastName nvarchar(20) NOT NULL,
		firstName nvarchar (30) NOT NULL,
		phone char(12) UNIQUE,
		Addr nvarchar (30) DEFAULT N'Hồ Chí Minh',
		DOB datetime CHECK (YEAR(GETDATE())-YEAR(DOB)>=18),
		Depart_ID char(10),
		CONSTRAINT priEm PRIMARY KEY (employ_ID),
		CONSTRAINT foreEm FOREIGN KEY (employ_ID) REFERENCES department(Depart_ID)
	)

Drop table employee5
--ALTER TABLE tablename 
--ADD CONSTRAINT constraintName FOREIGN KEY (<attribute list>)
--REFERENCES parentTableName (<attribute list>);
--ALTER TABLE tablename 
--ADD CONSTRAINT constraintName CHECK (expressionChecking)

CREATE TABLE employee7
	(
		employ_ID char(10) NOT NULL,
		lastName nvarchar(20) NOT NULL,
		firstName nvarchar (30) NOT NULL,
		phone char(12),
		Addr nvarchar (30),
		DOB datetime,
		Depart_ID char(10),
		Sex char(1) 
	)
--Cách 3 thêm constraint khóa chính khóa ngoại và check
ALTER TABLE employee7
ADD CONSTRAINT pri7_1 PRIMARY KEY (employ_ID);

ALTER TABLE employee7
ADD CONSTRAINT for7_1 FOREIGN KEY (Depart_ID) REFERENCES department(Depart_ID);

ALTER TABLE employee7
ADD CONSTRAINT sex_7 CHECK(Sex IN('M','F'))


--6. THEM XOA ATRRIBUTE TRONG BANG
--ALTER TABLE tableName
--ADD columnName datatype [constraint]
-- thêm cột sex
ALTER TABLE employee1
ADD sex nvarchar(5) 
--thêm giá trị cho cột sex
UPDATE employee1
SET sex=N'Nữ'

--ALTER TABLE tableName
--DROP columnName datatype [constraint]

--ALTER TABLE tableName
--ALTER columnName datatype [constraint]


--8. FOREIGN KEY
--	Attribute datatype FOREIGN KEY REFERENCES tablename(Attribute)
-- cách 1: tạo khóa chính khóa ngoại trực tiếp
CREATE TABLE department
	(
		Depart_ID char(10) PRIMARY KEY,
		NameDepart nvarchar(20)
	)
CREATE TABLE employee2
	(
		employ_ID char(10) PRIMARY KEY ,
		lastName nvarchar(20) NOT NULL,
		firstName nvarchar (30) NOT NULL,
		phone char(12) UNIQUE,
		Addr nvarchar (30) DEFAULT N'Hồ Chí Minh',
		DOB datetime CHECK (YEAR(GETDATE())-YEAR(DOB)>=18),
		Depart_ID char(10) FOREIGN KEY REFERENCES department(Depart_ID)
	)
--Cách 2: Tạo khóa chính, khóa ngoại bằng CONSTRAINT
CREATE TABLE employee5
	(
		employ_ID char(10) NOT NULL ,
		lastName nvarchar(20) NOT NULL,
		firstName nvarchar (30) NOT NULL,
		phone char(12) UNIQUE,
		Addr nvarchar (30) DEFAULT N'Hồ Chí Minh',
		DOB datetime CHECK (YEAR(GETDATE())-YEAR(DOB)>=18),
		Depart_ID char(10),
		CONSTRAINT prima PRIMARY KEY (employ_ID),
		CONSTRAINT Fore FOREIGN KEY (Depart_ID) REFERENCES department(Depart_ID) 
	)
-- Nhiều thuộc tính làm khóa chính
CREATE TABLE employee6
	(
		employ_ID char(10) NOT NULL ,
		lastName nvarchar(20) NOT NULL,
		firstName nvarchar (30) NOT NULL,
		phone char(12) UNIQUE,
		Addr nvarchar (30) DEFAULT N'Hồ Chí Minh',
		DOB datetime CHECK (YEAR(GETDATE())-YEAR(DOB)>=18),
		Depart_ID char(10),
		CONSTRAINT prim PRIMARY KEY (employ_ID,phone,DOB),
		CONSTRAINT Fore1 FOREIGN KEY (Depart_ID) REFERENCES department(Depart_ID) 
	)


--9.UPDATE 
--UPDATE tableName
--SET columnName = newValue
--[WHERE condition]
UPDATE employee1
SET Addr=N'Đồng Nai'

--10.DELETE
--DELETE FROM tableName
--[WHERE condition] 
DELETE FROM employee1
WHERE lastName LIKE 'Lê'

DROP TABLE employee1