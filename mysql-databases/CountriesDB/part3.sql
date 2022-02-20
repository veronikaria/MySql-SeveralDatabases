USE Countriesofworld

-- TASK 1

-- Представление ShowNationalsUkraine выводит всю информацию о национальном составе Украины
CREATE VIEW ShowNationalsUkraine
AS
SELECT n.* FROM Countries c
JOIN Population p ON c.PopulationId=p.Id
JOIN NationalPopulation np ON np.PopulationId=p.Id
JOIN `National` n ON n.Id=np.NationalId
WHERE c.Name = 'Україна'

-- Вывести все данные из представления ShowNationalsUkraine, при этом национальности должны заканчиваться буквой "и"
SELECT * FROM ShowNationalsUkraine
WHERE Nationality LIKE '%и'

-- Вывести все данные из представления ShowNationalsUkraine, при этом количество национальности
-- должна быть в пределах от 1 до 2 млн не включительно, посортировать по возрастанию количества
SELECT * FROM ShowNationalsUkraine
WHERE `Number`>1 AND `Number`<2
ORDER BY `Number` ASC

-- Представление ShowOceansUsa выводит все океаны Соединенных Штатов Америки
CREATE VIEW ShowOceansUsa
AS
SELECT o.* FROM Countries c
JOIN Location  l on c.LocationId=l.Id
JOIN LocationOcean lo on lo.LocationId=l.Id
JOIN Ocean o ON o.Id=lo.OceanId
WHERE c.Name='Сполучені Штати Америки'

-- Вывести названия океанов из представления ShowOceansUsa в алфавитном порядке
SELECT `Name` FROM ShowOceansUsa
ORDER BY `Name` ASC

-- Вывести количество океанов из представления ShowOceansUsa
SELECT COUNT(*) cnt_oceans FROM ShowOceansUsa

-- Проверим обновляемость таблиц представлений. Для этого
-- Изменим количество населения евреев с 1.3 на 0.7 млн
UPDATE `National`
SET `Number` = 0.7
WHERE Id=4

-- Теперь выполним такой же запрос:
-- Вывести все данные из представления ShowNationalsUkraine, при этом количество национальности
-- должна быть в пределах от 1 до 2 млн не включительно, посортировать по возрастанию количества
SELECT * FROM ShowNationalsUkraine
WHERE `Number`>1 AND `Number`<2
ORDER BY `Number` ASC
-- В результате будут только поляки, в отличие от предыдущего запроса


-- TASK 2
-- Создание вспомогательной таблицы NationalAudit для триггера
-- Таблица будет вести учет данных, добавлять страну и национальный состав
CREATE TABLE NationalAudit(
    Country  VARCHAR(100) ,
	Nationality VARCHAR(100)
)

-- Триггер на вставку данных
DELIMITER $$
CREATE TRIGGER NationalPopulationInsert
AFTER INSERT
ON `NationalPopulation`
FOR EACH ROW BEGIN
    INSERT INTO NationalAudit
    SET Country = (SELECT `Name` FROM Countries c WHERE c.PopulationId=NEW.PopulationId),
	Nationality = (SELECT n.Nationality FROM Countries c 
    JOIN NationalPopulation np ON np.PopulationId=c.PopulationId
    JOIN `National` n ON n.Id=np.NationalId
    WHERE n.Id=NEW.NationalId);
END$$
DELIMITER ;


INSERT `National`
(Nationality, `Number`, Percentage)
VALUES
('Німці', 0.8, 1)

INSERT NationalPopulation
(NationalId, PopulationId)
VALUES
(11, 1)

-- Результатом будет столбец Country-Украина Nationality-Немцы
SELECT * FROM NationalAudit




-- Триггер на обновление данных
DELIMITER $$
CREATE TRIGGER NationalUpdate
AFTER UPDATE
ON `National`
FOR EACH ROW BEGIN
	UPDATE `Population` 
    JOIN NationalPopulation ON
    NationalPopulation.PopulationId=Population.Id
    SET Quantity = Quantity + (NEW.Number-OLD.Number)
    WHERE NationalPopulation.NationalId=NEW.Id;
END$$
DELIMITER ;


UPDATE `National`
SET `Number`=3.45
WHERE Id=7

-- Результатом будет 20.74. Значение Number увеличилось на 1.45, поэтому значение Quantity
-- Для Румынии также увеличилось на 1.45 с помощью триггера NationalUpdate
SELECT p.* FROM Countries c
JOIN Population p ON c.PopulationId=p.Id
WHERE c.Name = 'Румунія'




-- TASK 3
-- Процедура ProcNationalByName будет выводить национальный состав страны,
-- что будет приниматься как входной параметр country
DELIMITER $$
CREATE PROCEDURE `ProcNationalByName`(IN country VARCHAR(100))
 BEGIN
 SELECT n.* FROM Countries c
JOIN Population p ON c.PopulationId=p.Id
JOIN NationalPopulation np ON np.PopulationId=p.Id
JOIN `National` n ON n.Id=np.NationalId
WHERE c.Name = country;
 END$$
DELIMITER ;

-- Вызов процедуры
CALL ProcNationalByName('Румунія')
CALL ProcNationalByName('Україна')
CALL ProcNationalByName('Сполучені Штати Америки')



-- Функция FuncCountNationalByName вычисляет и возвращает количество национального состава
-- страны, передаваемые как параметр в функцию
DELIMITER $$
CREATE FUNCTION `FuncCountNationalByName`(country VARCHAR(100))
RETURNS INT
DETERMINISTIC
 BEGIN
 DECLARE cnt INT;
 SET cnt = (SELECT COUNT(*) FROM Countries c
JOIN Population p ON c.PopulationId=p.Id
JOIN NationalPopulation np ON np.PopulationId=p.Id
JOIN `National` n ON n.Id=np.NationalId
WHERE c.Name = country);
RETURN (cnt);
 END$$
DELIMITER ;

-- Вызовы функции FuncCountNationalByName
SELECT FuncCountNationalByName('Румунія')  as cnt
SELECT FuncCountNationalByName('Україна')  as cnt
SELECT FuncCountNationalByName('Сполучені Штати Америки')  as cnt




 
 