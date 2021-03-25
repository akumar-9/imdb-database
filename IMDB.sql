CREATE TABLE Actors
(Id INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(30),
Sex NVARCHAR(10),
DOB DATE,
Bio NVARCHAR(255))

CREATE TABLE Producers
(Id INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(30),
Sex NVARCHAR(10),
DOB DATE,
Bio NVARCHAR(255))

CREATE TABLE Genres
(Id INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(30))

CREATE TABLE Movies
( Id INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(30),
YearOfRelease DATE,
Plot NVARCHAR(255),
Poster IMAGE ,
ProducerId INT FOREIGN KEY REFERENCES Producers(Id))

CREATE TABLE ActorMovieMapping
(Id INT IDENTITY(1,1) PRIMARY KEY,
ActorId INT FOREIGN KEY REFERENCES Actors(Id),
MovieId INT FOREIGN KEY REFERENCES Movies(Id))

CREATE TABLE MovieGenreMapping
(Id INT IDENTITY(1,1) PRIMARY KEY,
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
GenreID INT FOREIGN KEY REFERENCES Genres(Id),
)
