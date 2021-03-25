CREATE TABLE Actors( 
Id INT PRIMARY KEY IDENTITY(1,1), 
Name NVARCHAR(100), 
Gender NVARCHAR(10),
DOB DATE,
CreatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP,
UpdatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP)


CREATE TABLE Producers( 
Id INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(100),
Company NVARCHAR(30),
CompanyEstDate DATE,
CreatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP,
UpdatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP)

CREATE TABLE Movies(
Id INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(100),
Language NVARCHAR(10),
ProducerId INT FOREIGN KEY REFERENCES Producers(Id),
Profit INT,
CreatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP,
UpdatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP)

CREATE TABLE ActorMovieMapping( 
Id INT PRIMARY KEY IDENTITY(1,1),
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
ActorId INT FOREIGN KEY REFERENCES Actors(Id),
CreatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP,
UpdatedAt  DATETIME DEFAULT CURRENT_TIMESTAMP)
GO

CREATE TRIGGER Actor_update on Actors FOR UPDATE AS
BEGIN
  UPDATE Actors
	SET UpdatedAt = GETDATE()
	FROM Actors INNER JOIN Deleted D
	on Actors.Id=D.Id
END
GO

CREATE TRIGGER Producer_update on Producers FOR UPDATE AS
BEGIN
  UPDATE Producers
	SET UpdatedAt = GETDATE()
	FROM Producers INNER JOIN Deleted D
	on Producers.Id=D.Id
END
GO

CREATE TRIGGER Movie_update on Movies FOR UPDATE AS
BEGIN
  UPDATE Movies
	SET UpdatedAt = GETDATE()
	FROM Movies INNER JOIN Deleted D
	on Movies.Id=D.Id
END
GO 

CREATE TRIGGER ActorMovieMapping_update on ActorMovieMapping FOR UPDATE AS
BEGIN
  UPDATE ActorMovieMapping
	SET UpdatedAt = GETDATE()
	FROM ActorMovieMapping INNER JOIN Deleted D
	on ActorMovieMapping.Id=D.Id
END
GO

INSERT INTO Actors(Name, Gender, DOB) 
VALUES
('Mila Kunis','Female','11/14/1986'),
('Robert DeNiro','Male','07/10/1957'),
('George Michael','Male','11/23/1978'),
('Mike Scott','Male','08/06/1969'),
('Pam Halpert','Female','09/26/1996'),
('Dame Judi Dench','Female','04/05/1947')

INSERT INTO Producers(Name, Company,CompanyEstDate) 
VALUES
('Arjun','Fox','05/14/1998'),
('Arun','Bull','09/11/2004'),
('Tom','Hanks','11/03/1987'),
('Zeshan','Male','11/14/1996'),
('Nicole','Team Coco','09/26/1992'),
('test','test','1992')

INSERT INTO Movies(Name, Language, ProducerId, Profit) 
VALUES
('Rocky','English',1,10000),
('Rocky','Hindi',3,3000),
('Terminal','English',4,300000),
('Rambo','Hindi',2,93000),
('Rudy','English',5,9600)

INSERT INTO ActorMovieMapping(MovieId,ActorId) 
VALUES
(1,1),(1,3),(1,5),
(2,6),(2,5),(2,4),(2,2),
(3,3),(3,2),
(4,1),(4,6),(4,3),
(5,2),(5,5),(5,3)


--Update Profit of all the movies by +1000 where producer name contains 'run'
UPDATE Movies 
SET Profit = Profit + 1000 
FROM Movies M INNER JOIN Producers P 
ON M.ProducerId = P.Id 
WHERE P.Name LIKE '%run%'

--Find duplicate movies having the same name and their count
SELECT Name AS MovieName, COUNT(*) AS MovieCount 
FROM Movies 
GROUP	BY Name 
HAVING COUNT(*) > 1

--Find the oldest actor/actress for each movie
SELECT R.Name,  A.Name 
FROM 
(
SELECT M.Id,M.Name, MIN(A.DOB) AS MinimumDOB
FROM Actors A INNER JOIN ActorMovieMapping AM 
ON A.Id = AM.ActorId
INNER JOIN Movies M 
ON AM.MovieId = M.Id
GROUP BY M.Id,M.Name
)R 
INNER JOIN ActorMovieMapping AM 
ON AM.MovieId = R.Id INNER JOIN Actors A 
ON A.Id = AM.ActorId
WHERE A.DOB = MinimumDOB

--List of producers who have not worked with actor 'Mila Kunis'
--Approach using IN 
SELECT p.Name 
FROM Producers p 
WHERE p.Id NOT IN
(
SELECT p.Id
FROM Producers p,
	(SELECT m.Name 'Movie Name',a.Name 'Actor Name',m.ProducerId,am.ActorId
	FROM Movies m , ActorMovieMapping am, Actors a
	WHERE m.id =  am.MovieId
	AND am.ActorId = a.Id
	AND a.Name = 'mila kunis'
	) r 
WHERE P.Id = r.ProducerId)

--		( OR )

-- Approach using left join
SELECT P.* , R.*
FROM Producers P LEFT JOIN 
	(
	SELECT M.ProducerId, AM.ActorId
	FROM  Movies M 
	INNER JOIN ActorMovieMapping AM 
	ON M.Id = AM.MovieId
	INNER JOIN Actors A 
	ON AM.ActorId = a.Id
	WHERE A.Name = 'Mila Kunis'
	) R 
ON R.ProducerId = P.Id
WHERE R.ProducerId IS NULL

--List of pair of actors who have worked together in more than 2 movies
SELECT A1.name, A2.name, CNT 
FROM Actors A1
INNER JOIN 
	(
	SELECT AM1.ActorId,AM2.ActorId as Actorid2, COUNT(*) CNT
	FROM ActorMovieMapping AM1 JOIN ActorMovieMapping AM2 
	ON (AM1.ActorId > AM2.ActorId AND AM1.MovieId = AM2.MovieId)
	GROUP BY AM1.ActorId,AM2.ActorId
	HAVING COUNT(*) >= 2
	) R 
ON A1.Id = R.ActorId
INNER JOIN  Actors A2 ON R.Actorid2 = A2.Id

--Add non-clustered index on profit column of movies table
CREATE NONCLUSTERED INDEX movies_profit ON Movies(Profit)
GO
--Create stored procedure to return list of actors for given movie id
CREATE PROCEDURE SelectAllActors @MovieID INT  
AS  
BEGIN
	SELECT A.Name   
	FROM Actors A   
	INNER JOIN ActorMovieMapping AMM  
	ON AMM.ActorId = A.Id  
	WHERE AMM.MovieId = @MovieID
END
GO
--Create a function to return age for given date of birth
CREATE FUNCTION CalculateAge( @DOB DATE)
RETURNS INT
AS
BEGIN
RETURN ( SELECT DATEDIFF(YEAR, @DOB, CURRENT_TIMESTAMP) )
END
GO
--Create a stored procedure to increase the profit (+100) of movies with given Ids (comma separated) 
CREATE PROCEDURE IncrementProfit @MovieIds varchar(20)  
AS  
UPDATE Movies 
SET Profit = Profit + 100 
WHERE Id 
IN (SELECT * FROM string_split(@MovieIds,','))
