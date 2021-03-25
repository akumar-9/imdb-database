--CREATE TABLE Actors( Id INT PRIMARY KEY IDENTITY(1,1), 
--Name NVARCHAR(30), 
--Gender NVARCHAR(10),
--DOB DATE)

--CREATE TABLE Producers( Id INT PRIMARY KEY IDENTITY(1,1),
--Name NVARCHAR(30),
--Company NVARCHAR(30),
--CompanyEstDate DATE,
--CreatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP)

--CREATE TABLE Movies(Id INT PRIMARY KEY IDENTITY(1,1),
--Name NVARCHAR(30),
--Language NVARCHAR(10),
--ProducerId INT FOREIGN KEY REFERENCES Producers(Id),
--Profit INT,
--CreatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP)

--CREATE TABLE ActorMovieMapping( Id INT PRIMARY KEY IDENTITY(1,1),
--MovieId INT FOREIGN KEY REFERENCES Movies(Id),
--ActorId INT FOREIGN KEY REFERENCES Actors(Id),
--CreatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP)

--INSERT INTO Actors(Name, Gender, DOB) VALUES('
--Robert DeNiro','Male','07/10/1957')
--INSERT INTO Actors(Name, Gender, DOB) VALUES(

--'George Michael',
--'Male',
--'11/23/1978'

--)
--INSERT INTO Actors(Name, Gender, DOB) VALUES('Mike Scott','Male','08/06/1969')
--INSERT INTO Actors(Name, Gender, DOB) VALUES('Pam Halpert','Female','09/26/1996')
--INSERT INTO Actors(Name, Gender, DOB) VALUES('Dame Judi Dench','Female','04/05/1947')


--SELECT * FROM Actors

--INSERT INTO Producers(Name, Company,CompanyEstDate) VALUES('Arjun','Fox','05/14/1998')
--INSERT INTO Producers(Name, Company,CompanyEstDate) VALUES('Arun','Bull','09/11/2004')
--INSERT INTO Producers(Name, Company,CompanyEstDate) VALUES('Tom','Hanks','11/03/1987')
--INSERT INTO Producers(Name, Company,CompanyEstDate) VALUES('Zeshan','Male','11/14/1996')
--INSERT INTO Producers(Name, Company,CompanyEstDate) VALUES('Nicole','Team Coco','09/26/1992')


--INSERT INTO Movies(Name, Language, ProducerId, Profit) VALUES('Rocky','English',1,10000)
--INSERT INTO Movies(Name, Language, ProducerId, Profit) VALUES('Rocky','Hindi',3,3000)
--INSERT INTO Movies(Name, Language, ProducerId, Profit) VALUES('Terminal','English',4,300000)
--INSERT INTO Movies(Name, Language, ProducerId, Profit) VALUES('Rambo','Hindi',2,93000)
--INSERT INTO Movies(Name, Language, ProducerId, Profit) VALUES('Rudy','English',5,9600)


--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(1,1)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(1,3)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(1,5)

--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(2,6)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(2,5)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(2,4)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(2,2)

--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(3,3)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(3,2)

--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(4,1)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(4,6)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(4,3)

--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(5,2)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(5,5)
--INSERT INTO ActorMovieMapping(MovieId,ActorId) VALUES(5,3)




--UPDATE Movies SET Profit = Profit + 1000 
--FROM Movies M INNER JOIN Producers P ON M.ProducerId = P.Id 
--WHERE P.Name LIKE '%run%'

--SELECT Name AS MovieName, COUNT(*) AS MovieCount 
--FROM Movies 
--GROUP	BY Name 
--HAVING COUNT(*) > 1

--SELECT R.Name,  A.Name from (
--SELECT M.Id,M.Name, MIN(A.DOB) AS MinimumDOB
--FROM Actors A INNER JOIN ActorMovieMapping AM ON A.Id = AM.ActorId
--INNER JOIN Movies M ON AM.MovieId = M.Id
--GROUP BY M.Id,M.Name
--)R JOIN ActorMovieMapping AM ON AM.MovieId = R.Id JOIN Actors A ON A.Id = AM.ActorId
--WHERE A.DOB = MinimumDOB

--SELECT p.Name FROM
--Producers p WHERE p.Id NOT IN
--(SELECT p.Id
--FROM Producers p,
--(SELECT m.Name 'Movie Name',a.Name 'Actor Name',m.ProducerId,am.ActorId
--FROM Movies m , ActorMovieMapping am, Actors a
--WHERE m.id =  am.MovieId
--AND am.ActorId = a.Id
--AND a.Name = 'mila kunis'
--) r 
--WHERE P.Id = r.ProducerId)

		--( OR )


--select p.* , r.*from producers p left join (select m.ProducerId, am.ActorId
--from  Movies M 
--inner join ActorMovieMapping am on m.Id = am.MovieId
--inner join Actors a on am.ActorId = a.Id
--where a.name = 'Mila Kunis')r 
--on r.ProducerId = p.Id
--where r.ProducerId IS NULL

--SELECT a1.name, a2.name FROM Actors a1
--INNER JOIN 
--(SELECT am1.ActorId,am2.ActorId as actorid2, COUNT(*) cnt
--FROM ActorMovieMapping am1 JOIN ActorMovieMapping am2 ON (am1.ActorId > am2.ActorId AND am1.MovieId = am2.MovieId)
--GROUP BY am1.ActorId,am2.ActorId
--HAVING COUNT(*) >= 2) r ON a1.Id = r.ActorId
--INNER JOIN  Actors a2 ON r.actorid2 = a2.Id

--CREATE NONCLUSTERED INDEX movies_profit ON Movies(Profit)
--EXEC SelectAllActors @MovieID = 1
--SELECT dbo.AGE(A.DOB) FROM Actors A;
--EXEC IncreaseProfit @MovieIds = '4,5'

