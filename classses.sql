CREATE TABLE Classes(Id INT IDENTITY(1,1) PRIMARY KEY, Name NVARCHAR(20),Section NVARCHAR(10), Number INT)
CREATE TABLE Teachers(Id INT IDENTITY(1,1) PRIMARY KEY, Name NVARCHAR(20), DOB Date, Gender NVARCHAR(10))
CREATE TABLE Students(Id INT IDENTITY(1,1) PRIMARY KEY, Name NVARCHAR(20), DOB Date, Gender NVARCHAR(10), ClassId INT FOREIGN KEY REFERENCES Classes(Id))
CREATE TABLE TeacherClassMapping(TeacherId INT FOREIGN KEY REFERENCES Teachers(Id), ClassId INT FOREIGN KEY REFERENCES Classes(Id));

INSERT INTO Classes values ('IX','A',201)
INSERT INTO Classes values ('IX','B',202)
INSERT INTO Classes values ('X','A',203)

INSERT INTO Teachers values ('Lisa Kudrow','1985/06/08','Female')
INSERT INTO Teachers values ('Monica Bing','1982/03/06','Female')
INSERT INTO Teachers values ('Chandler Bing','1978/12/17','Male')
INSERT INTO Teachers values ('Ross Geller','1993/01/26','Male')

INSERT INTO Students values ('Scotty Loman','2006/01/31','Male',1)
INSERT INTO Students values ('Adam Scott','2005/06/01','Male',1)
INSERT INTO Students values ('Natosha Beckles','2005/01/23','Female',2)
INSERT INTO Students values ('Lilly Page','2006/11/26','Female',2)
INSERT INTO Students values ('John Freeman','2006/06/14','Male',2)
INSERT INTO Students values ('Morgan Scott','2005/05/18','Male',3)
INSERT INTO Students values ('Codi Gass','2005/12/24','Female',3)
INSERT INTO Students values ('Nick Roll','2005/12/24','Male',3)
INSERT INTO Students values ('Dave Grohl','2005/02/12','Male',3)

INSERT INTO TeacherClassMapping values (1,1)
INSERT INTO TeacherClassMapping values (1,2)
INSERT INTO TeacherClassMapping values (2,2)
INSERT INTO TeacherClassMapping values (2,3)
INSERT INTO TeacherClassMapping values (3,3)
INSERT INTO TeacherClassMapping values (3,1)


SELECT * FROM Students WHERE Gender = 'Male';
SELECT * FROM Students WHERE DOB >= '2005/01/01';
SELECT * FROM Students WHERE DOB = (select MAX(DOB) FROM Students);
SELECT DISTINCT DOB FROM Students;
SELECT ClassId, COUNT(*) as Count FROM Students GROUP BY ClassId;
SELECT C.Section, COUNT(*) AS Count from Classes C INNER JOIN Students S ON C.Id = S.ClassId GROUP BY C.Section;
SELECT  T.Name , COUNT(*) AS Count FROM Teachers T INNER JOIN TeacherClassMapping TCM ON T.Id = TCM.TeacherId GROUP BY T.Name;
SELECT T.Name , C.Name, C.Section FROM Teachers T INNER JOIN TeacherClassMapping TCM ON T.Id = TCM.TeacherId INNER JOIN Classes C ON C.Id = TCM.ClassId WHERE C.Name = 'ix'
SELECT ClassId FROM TeacherClassMapping GROUP BY ClassId HAVING COUNT(*) > 2
SELECT S.* FROM Students S INNER JOIN Classes C ON C.Id = S.ClassId INNER JOIN TeacherClassMapping TCM ON TCM.ClassId = C.Id INNER JOIN Teachers T ON T.Id = TCM.TeacherId WHERE T.Name LIKE '%Lisa%'
SELECT C.name as Class_Name 
FROM Classes C
JOIN TeacherClassMapping TCM
ON TCM.ClassId = C.Id
JOIN Teachers T
ON T.id = TCM.TeacherId
GROUP BY C.name
HAVING COUNT(TCM.TeacherId)>2

