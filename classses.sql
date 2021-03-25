CREATE TABLE Classes(
Id INT IDENTITY(1,1) PRIMARY KEY, 
Name NVARCHAR(20), 
Section NVARCHAR(10), 
Number INT)

CREATE TABLE Teachers(
Id INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(20), DOB Date,
Gender NVARCHAR(10))

CREATE TABLE Students(
Id INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(20), 
DOB Date, 
Gender NVARCHAR(10), 
ClassId INT FOREIGN KEY REFERENCES Classes(Id))

CREATE TABLE TeacherClassMapping(
TeacherId INT FOREIGN KEY REFERENCES Teachers(Id),
ClassId INT FOREIGN KEY REFERENCES Classes(Id));

INSERT INTO Classes(Name,Section,Number) 
values 
('IX','A',201),
('IX','B',202),
('X','A',203)

INSERT INTO Teachers(Name,DOB,Gender) 
values 
('Lisa Kudrow','1985/06/08','Female'),
('Monica Bing','1982/03/06','Female'),
('Chandler Bing','1978/12/17','Male'),
('Ross Geller','1993/01/26','Male')

INSERT INTO Students(Name,DOB,Gender,ClassId) 
values
('Scotty Loman','2006/01/31','Male',1),
('Adam Scott','2005/06/01','Male',1),
('Natosha Beckles','2005/01/23','Female',2),
('Lilly Page','2006/11/26','Female',2),
('John Freeman','2006/06/14','Male',2),
('Morgan Scott','2005/05/18','Male',3),
('Codi Gass','2005/12/24','Female',3),
('Nick Roll','2005/12/24','Male',3),
('Dave Grohl','2005/02/12','Male',3)

INSERT INTO TeacherClassMapping(TeacherId,ClassId) values 
(1,1),
(1,2),
(2,2),
(2,3),
(3,3),
(3,1)

--Find list of male students 
SELECT * 
FROM Students 
WHERE Gender = 'Male';

--Find list of student older than 2005/01/01
SELECT * 
FROM Students 
WHERE DOB >= '2005/01/01';

--Youngest student in school
SELECT * 
FROM Students 
WHERE DOB = (select MAX(DOB) FROM Students);

--Find student distinct birthdays
SELECT DISTINCT DOB 
FROM Students;

-- No of students in each class
SELECT ClassId, COUNT(*) as Count 
FROM Students 
GROUP BY ClassId;

-- No of students in each section
SELECT C.Section, COUNT(*) AS Count 
FROM Classes C INNER JOIN Students S 
ON C.Id = S.ClassId 
GROUP BY C.Section;

-- No of classes taught by teacher
SELECT  T.Name , COUNT(*) AS Count 
FROM Teachers T INNER JOIN TeacherClassMapping TCM 
ON T.Id = TCM.TeacherId 
GROUP BY T.Name;

-- List of teachers teaching Class X
SELECT T.Name , C.Name, C.Section 
FROM Teachers T INNER JOIN TeacherClassMapping TCM 
ON T.Id = TCM.TeacherId 
INNER JOIN Classes C 
ON C.Id = TCM.ClassId 
WHERE C.Name = 'x'

--Classes which have more than 2 teachers teaching
SELECT C.name as Class_Name 
FROM Classes C
JOIN TeacherClassMapping TCM
ON TCM.ClassId = C.Id
JOIN Teachers T
ON T.id = TCM.TeacherId
GROUP BY C.name
HAVING COUNT(TCM.TeacherId)>2

-- List of students being taught by 'Lisa'
SELECT S.* 
FROM Students S INNER JOIN Classes C 
ON C.Id = S.ClassId INNER JOIN TeacherClassMapping TCM 
ON TCM.ClassId = C.Id INNER JOIN Teachers T 
ON T.Id = TCM.TeacherId 
WHERE T.Name LIKE '%Lisa%'



