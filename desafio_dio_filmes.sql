-- Script completo do Desafio DIO - Banco de Dados Filmes

CREATE TABLE Atores (
    Id INT PRIMARY KEY IDENTITY,
    PrimeiroNome VARCHAR(20),
    UltimoNome VARCHAR(20),
    Genero VARCHAR(1)
);

CREATE TABLE Filmes (
    Id INT PRIMARY KEY IDENTITY,
    Nome VARCHAR(50),
    Ano INT,
    Duracao INT
);

CREATE TABLE Generos (
    Id INT PRIMARY KEY IDENTITY,
    Genero VARCHAR(20)
);

CREATE TABLE ElencoFilme (
    Id INT PRIMARY KEY IDENTITY,
    IdAtor INT NOT NULL,
    IdFilme INT,
    Papel VARCHAR(30),

    CONSTRAINT FK_ElencoFilme_Ator 
        FOREIGN KEY (IdAtor) REFERENCES Atores(Id),

    CONSTRAINT FK_ElencoFilme_Filme 
        FOREIGN KEY (IdFilme) REFERENCES Filmes(Id)
);

CREATE TABLE FilmesGenero (
    Id INT PRIMARY KEY IDENTITY,
    IdGenero INT,
    IdFilme INT,

    CONSTRAINT FK_FilmesGenero_Genero 
        FOREIGN KEY (IdGenero) REFERENCES Generos(Id),

    CONSTRAINT FK_FilmesGenero_Filme 
        FOREIGN KEY (IdFilme) REFERENCES Filmes(Id)
);

-- Inserts de exemplo

INSERT INTO Atores (PrimeiroNome, UltimoNome, Genero)
VALUES ('Robert', 'Downey Jr', 'M'),
       ('Scarlett', 'Johansson', 'F');

INSERT INTO Filmes (Nome, Ano, Duracao)
VALUES ('Homem de Ferro', 2008, 126),
       ('Vingadores', 2012, 143);

INSERT INTO Generos (Genero)
VALUES ('Ação'),
       ('Ficção Científica');

INSERT INTO ElencoFilme (IdAtor, IdFilme, Papel)
VALUES (1, 1, 'Tony Stark'),
       (2, 2, 'Viúva Negra');

INSERT INTO FilmesGenero (IdGenero, IdFilme)
VALUES (1, 1),
       (2, 2);

-- Consultas de exemplo

-- Atores e seus filmes
SELECT 
    A.PrimeiroNome,
    A.UltimoNome,
    F.Nome AS Filme,
    EF.Papel
FROM ElencoFilme EF
JOIN Atores A ON EF.IdAtor = A.Id
JOIN Filmes F ON EF.IdFilme = F.Id;

-- Filmes com seus gêneros
SELECT 
    F.Nome AS Filme,
    G.Genero
FROM FilmesGenero FG
JOIN Filmes F ON FG.IdFilme = F.Id
JOIN Generos G ON FG.IdGenero = G.Id;
