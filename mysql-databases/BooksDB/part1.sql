-- TASK 1
CREATE DATABASE booksdb

USE booksdb

CREATE TABLE Books (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Author VARCHAR(50) NOT NULL,
	`Name` VARCHAR(50) NOT NULL,
	Numbers_account INT NOT NULL,
    Numbers_stock INT NOT NULL
)

ALTER TABLE Books
ADD `Level` INT NULL;

INSERT Books(Author, `Name`, Numbers_account, Numbers_stock, `Level`)
VALUES
('Мішель Онфре', 'Сила життя', 32,  3, 1), 
('Сунь Цзи', 'Мистецтво війни', 54,  2, 1), 
('Тарас Лютий', 'Ніцше. Самоперевершення', 62,  6, 3), 
('Марк Аврелій', 'Наодинці з собою', 31,  7, 5), 
('Генрі Девід Торо', 'Волден, або Життя в лісах', 38,  2, 1), 
('Джозеф Кемпбелл', 'Тисячоликий герой', 18,  2, 5), 
('Фрідріх Ніцше', 'Жадання влади', 19,  7, 1), 
('Фрідріх Ніцше', 'Весела наука', 92,  8, 2), 
('Ібн Сіна', 'Логіка. Фізика. Метафізика', 82,  5, 5), 
('Емануеле Северино', 'Сутність нігілізму', 78,  9, 5)

-- книги, имеющие самый высокий спрос
SELECT * FROM Books
WHERE `Level` = (
	SELECT MAX(`Level`) FROM books
)

-- книги, имеющие наименьшее количество в наличии
SELECT * FROM Books
WHERE Numbers_stock = (
	SELECT MIN(Numbers_stock) FROM books
)


CREATE TABLE Magazines
(
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(100) NOT NULL,
    Edition VARCHAR(50) NOT NULL
)

INSERT Magazines
(`Name`, Edition)
VALUES
('Український тиждень', 'Український тиждень'),
('LEGO Explorer. Вчимося разом. Неймовірні рослини', 'Егмонт'),
('Локальна історія', 'УГА'),
('Nаціоналістичний Ідеологічний Журнал', 'Орієнтир'),
('Кіно-Театр', 'УГА')

-- Изменить издательство на Ориентир у журнала под названием Кино-Театр
UPDATE Magazines
SET Edition = 'Орієнтир'
WHERE `Name`='Кіно-Театр'


-- Изменить тип столбца Издательство на VARCHAR(70)
ALTER TABLE Magazines 
MODIFY Edition VARCHAR(70) NOT NUll

-- Изменить название таблицы Magazines на Journals
RENAME TABLE Magazines TO Journals

-- Удалить все журналы, в которых издательство Ориентир
DELETE FROM Journals
WHERE Edition = 'Орієнтир'


-- Удалить столбец издательство
ALTER TABLE Journals
DROP COLUMN Edition

-- Удалить таблицу Журналы
DROP TABLE Journals


-- TASK 3
CREATE TABLE `Client`
(
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    LastName VARCHAR(30) NOT NULL NOT NULL,
    FirstName VARCHAR(30) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Address VARCHAR(50) NOT NULL
)


CREATE TABLE `Order`
(
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClientId INT NOT NULL,
    BookId INT NOT NULL,
    `Date` DATE NULL,
    FOREIGN KEY (ClientId)  REFERENCES `Client` (Id),
    FOREIGN KEY (BooksId)  REFERENCES Books (Id)
)

INSERT `Client`
(LastName, FirstName, City, Address)
VALUES
('Петров', 'Петро', 'Київ', 'Шевченка 18/71'),
('Іванов', 'Іван', 'Львів', 'Стуса 29/1'),
('Якимів', 'Андрій', 'Київ', 'Грушевського 98/97')

INSERT `Order`
(ClientId, BookId, `Date`)
VALUES
(1, 10, '2021/11/24'), 
(2, 4, '2021/11/24'),
(3, 2, '2021/11/24'),
(3, 1, '2021/11/23'),
(2, 2, '2021/11/23'),
(1, 8, '2021/11/19')


-- Вывести все названия книг, которые были заказаны 23 ноября
SELECT `Name` FROM Books AS b
JOIN `Order` AS o ON b.Id=o.BookId
WHERE o.`Date`='2021/11/23'


-- Вывести название книги и фамилии заказчиков, купивших книгу, в названии которой содержится буква "н"
SELECT b.`Name` AS Name_Book, c.LastName 
FROM Books AS b 
JOIN `Order` AS o ON o.BookId=b.Id
JOIN `Client` AS c ON c.Id=o.ClientId
WHERE b.`Name` LIKE '%н%'

-- Вывести все книги, в которых уровень в пределах от 2 до 5
SELECT * FROM Books
WHERE `LEVEL`>=2 AND `LEVEL`<=5

-- Вывести все названия еще не заказываемых книг в алфавитном порядке
SELECT b.`Name` AS Name_Book
FROM Books AS b 
LEFT JOIN `Order` AS o ON o.BookId=b.Id
WHERE o.BookId IS NULL
ORDER BY b.`Name` ASC

-- Вывести названия книг и сколько раз их заказывали (если книгу не заказывали, в результат ее не вносить)
-- При этом количество заказов должно быть больше или равно 2.
SELECT b.`Name` AS Name_Book, COUNT(*) AS Cnt 
FROM Books AS b 
RIGHT JOIN `Order` AS o ON o.BookId=b.Id
GROUP BY b.`Name`
HAVING Cnt>=2

