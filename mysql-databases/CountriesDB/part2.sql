CREATE DATABASE CountriesOfWorld

USE CountriesOfWorld

CREATE TABLE `National`(
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Nationality VARCHAR(100) NOT NULL,
	`Number` FLOAT NULL,
    Percentage FLOAT NOT NULL
)

CREATE TABLE Population (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Quantity FLOAT NOT NULL,
	StateLanguage VARCHAR(100) NULL
)

CREATE TABLE NationalPopulation(
	NationalId INT NOT NULL,
	PopulationId INT NOT NULL,
    PRIMARY KEY (NationalId, PopulationId),
    FOREIGN KEY (NationalId)  REFERENCES `National` (Id),
    FOREIGN KEY (PopulationId)  REFERENCES Population (Id)
)

CREATE TABLE Ocean (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(100) NOT NULL
)

CREATE TABLE Sea (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(100) NOT NULL
)

CREATE TABLE MountainRange (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(100) NOT NULL
)

CREATE TABLE Location (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	PartOfWorld VARCHAR(100) NOT NULL,
	Continent VARCHAR(100) NOT NULL
)

CREATE TABLE LocationSea(
	LocationId INT NOT NULL,
    SeaId INT NOT NULL,
    PRIMARY KEY (LocationId, SeaId),
	FOREIGN KEY (SeaId)  REFERENCES Sea (Id),
	FOREIGN KEY (LocationId)  REFERENCES Location (Id)
)

CREATE TABLE LocationOcean(
	LocationId INT NOT NULL,
    OceanId INT NOT NULL,
    PRIMARY KEY (LocationId, OceanId),
	FOREIGN KEY (OceanId)  REFERENCES Ocean (Id),
	FOREIGN KEY (LocationId)  REFERENCES Location (Id)
)

CREATE TABLE LocationMountainRange(
	LocationId INT NOT NULL,
    MountainRangeId INT NOT NULL,
    PRIMARY KEY (LocationId, MountainRangeId),
	FOREIGN KEY (MountainRangeId)  REFERENCES MountainRange (Id),
	FOREIGN KEY (LocationId)  REFERENCES Location (Id)
)

CREATE TABLE Countries (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(50) NOT NULL,
	Area FLOAT NOT NULL,
    PopulationId INT NOT NULL,
    LocationId INT NOT NULL,
    FOREIGN KEY (LocationId)  REFERENCES Location (Id),
    FOREIGN KEY (PopulationId)  REFERENCES Population (Id)
)

-- Заполняем данные для Украины
INSERT Sea (`Name`) 
VALUES
('Чорне'),
('Азовське')

INSERT MountainRange
(`Name`)
VALUES
('Карпати'),
('Чорногора')

INSERT Location
(PartOfWorld, Continent)
VALUES
('Європа', 'Європа')

INSERT LocationSea
(LocationId, SeaId)
VALUES
(1, 1),
(1, 2)

INSERT LocationMountainRange
(LocationId, MountainRangeId)
VALUES
(1, 1),
(1, 2)

INSERT Population
(Quantity, StateLanguage)
VALUES
(44.13, 'Українська')

INSERT `National`
(Nationality, `Number`, Percentage)
VALUES
('Українці', 39, 92),
('Росіяни', 2.1, 4),
('Поляки', 1.9, 2.4),
('Євреї', 1.3, 1.6)

INSERT NationalPopulation
(NationalId, PopulationId)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1)

INSERT Countries
(`Name`, Area, PopulationId, LocationId)
VALUES
('Україна', 603628, 1, 1)

-- Заполняем данные для Румынии

INSERT MountainRange
(`Name`)
VALUES
('Пояна-Руске'),
('Біхор'),
('Бучеджі'),
('Фегераш')

INSERT Location
(PartOfWorld, Continent)
VALUES
('Європа', 'Європа')

INSERT LocationSea
(LocationId, SeaId)
VALUES
(2, 1)

INSERT LocationMountainRange
(LocationId, MountainRangeId)
VALUES
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6)

INSERT Population
(Quantity, StateLanguage)
VALUES
(19.29, 'Румунська')

INSERT `National`
(Nationality, `Number`, Percentage)
VALUES
('Румуни', 15, 90),
('Угорці', 2.29, 6),
('Роми', 2, 4)

INSERT NationalPopulation
(NationalId, PopulationId)
VALUES
(5, 2),
(6, 2),
(7, 2)

INSERT Countries
(`Name`, Area, PopulationId, LocationId)
VALUES
('Румунія', 238397, 2, 2)

-- Заполняем данные для Соединенных Штатов Америки

INSERT MountainRange
(`Name`)
VALUES
('Уошито'),
('Манзано'),
('Сакраменто'),
('Адірондак')

INSERT Location
(PartOfWorld, Continent)
VALUES
('Америка', 'Північна Америка')

INSERT Ocean
(`Name`)
VALUES
('Тихий'),
('Атлантичний')

INSERT LocationOcean
(LocationId, OceanId)
VALUES
(3, 1),
(3, 2)

INSERT LocationMountainRange
(LocationId, MountainRangeId)
VALUES
(3, 7),
(3, 8),
(3, 9),
(3, 10)

INSERT Population
(Quantity, StateLanguage)
VALUES
(329.5, 'Англійська')

INSERT `National`
(Nationality, `Number`, Percentage)
VALUES
('Американці', 305, 95),
('Німці', 3, 2),
('Шведи', 2, 1.6)

INSERT NationalPopulation
(NationalId, PopulationId)
VALUES
(8, 3),
(9, 3),
(10, 3)

INSERT Countries
(`Name`, Area, PopulationId, LocationId)
VALUES
('Сполучені Штати Америки', 9834000, 3, 3)

-- TASK 1
--  Найти страну, в которой минимальная численность населения.
SELECT  c.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
WHERE p.Quantity = (
	SELECT MIN(Quantity) FROM Population 
)


-- TASK 2
-- Найти все страны находящиеся на материке Европа с населением менее 25млн
SELECT  c.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
WHERE l.Continent = 'Європа'
AND p.Quantity < 25


-- Найти все страны находящиеся на материке Европа с населением менее 100млн.
SELECT  c.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
WHERE l.Continent = 'Європа'
AND p.Quantity < 100


-- Найти все страны, находящиеся на материке Северная Америка с населением менее 600 млн
SELECT  c.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
WHERE l.Continent = 'Північна Америка'
AND p.Quantity < 600

-- TASK 3
-- Найти все страны, не имеющие выхода к морю.
SELECT c.Name FROM Countries AS c
LEFT JOIN Location AS l ON l.Id=c.LocationId
LEFT JOIN LocationSea AS ls ON ls.LocationId=l.Id
WHERE ls.SeaId IS NULL


-- TASK 4
-- Найти страны, которые омывают наиболее морей.
SELECT c.Name, COUNT(*) cnt FROM Countries AS c
LEFT JOIN Location AS l ON l.Id=c.LocationId
LEFT JOIN LocationSea AS ls ON ls.LocationId=l.Id
GROUP BY c.Name
ORDER BY cnt DESC
LIMIT 1


-- TASK 5
-- Найти все страны, на территории которых находится горный хребет - Карпаты
SELECT  c.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationMountainRange lm ON lm.LocationId = l.Id
JOIN MountainRange m ON lm.MountainRangeId = m.Id
WHERE m.Name = 'Карпати'

-- Найти все страны, на территории которых находится горный хребет - Бихор.
SELECT  c.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationMountainRange lm ON lm.LocationId = l.Id
JOIN MountainRange m ON lm.MountainRangeId = m.Id
WHERE m.Name = 'Біхор'


-- Найти все страны, на территории которых находится горный хребет - Уошито.
SELECT  c.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationMountainRange lm ON lm.LocationId = l.Id
JOIN MountainRange m ON lm.MountainRangeId = m.Id
WHERE m.Name = 'Уошито'


-- TASK 6
-- Найти все страны, в которых название части света совпадает с названием материка.
SELECT c.Name FROM Countries AS c
JOIN Location AS l ON l.Id=c.LocationId
WHERE l.PartOfWorld=l.Continent


-- TASK 7
-- Найти все горные хребты, находящиеся на территории указанной страны – Украина.
SELECT  m.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationMountainRange lm ON lm.LocationId = l.Id
JOIN MountainRange m ON lm.MountainRangeId = m.Id
WHERE c.Name='Україна'


-- Найти все горные хребты, находящиеся на территории указанной страны – Румыния.
SELECT  m.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationMountainRange lm ON lm.LocationId = l.Id
JOIN MountainRange m ON lm.MountainRangeId = m.Id
WHERE c.Name='Румунія'


-- Найти все горные хребты, находящиеся на территории указанной страны – Соединенные Штаты Америки.
SELECT  m.Name FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationMountainRange lm ON lm.LocationId = l.Id
JOIN MountainRange m ON lm.MountainRangeId = m.Id
WHERE c.Name='Сполучені Штати Америки'


-- TASK 8
--  Найти все страны, в которых численность населения больше заданной величины - 10, и материки, на которых они находятся
SELECT  c.Name, l.Continent FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
WHERE p.Quantity > 10

--  Найти все страны, в которых численность населения больше заданной величины - 250, и материки, на которых они находятся
SELECT  c.Name, l.Continent FROM Countries AS c
JOIN Population AS p ON c.PopulationId=p.Id
JOIN Location AS l ON l.Id=c.LocationId
WHERE p.Quantity > 250


-- TASK 9
-- Найти все страны омываемые указанным морем - Черным
SELECT  c.Name FROM Countries AS c
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationSea ls ON ls.LocationId = l.Id
JOIN Sea s ON s.Id = ls.SeaId
WHERE s.Name = 'Чорне'


-- Найти все страны омываемые указанным морем - Азовским
SELECT c.Name FROM Countries AS c
JOIN Location AS l ON l.Id=c.LocationId
JOIN LocationSea ls ON ls.LocationId = l.Id
JOIN Sea s ON s.Id = ls.SeaId
WHERE s.Name = 'Азовське'


-- TASK 10
-- Вывести названия стран и количество их национального состава, посортировать одновременно количество по росту, а название по убыванию
SELECT c.Name, COUNT(*) AS cnt FROM Countries AS c
JOIN Population p ON c.PopulationId=p.Id
JOIN NationalPopulation np ON np.PopulationId=p.Id
JOIN `National` n ON n.Id = np.NationalId
GROUP BY c.Name
ORDER BY cnt ASC, c.Name DESC



