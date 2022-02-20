

-- Дополнительная таблица для триггера
CREATE TABLE TempTablePatient
(
	FullName VARCHAR(50),
    `Date` DATE
)

-- Триггер для вставки данных. Данный триггер будет вставлять данные в таблицу TempTablePatient
-- при добавлении данных в таблицу Appeal. FullName - ФИО пациента в виде "Фамилия И.Б."
DELIMITER $$
CREATE TRIGGER AppealInsert
AFTER INSERT
ON `Appeal`
FOR EACH ROW BEGIN
    INSERT INTO TempTablePatient
    SET FullName = 
    (SELECT CONCAT(LastName, ' ', LEFT(FirstName, 1), '. ', LEFT(MiddleName, 1), ' ') 
    FROM Patient p 
    JOIN Appeal a ON a.IdPatient=p.Id
    WHERE a.Id=NEW.Id),`Date` = NEW.`Date`;
END$$
DELIMITER ;

INSERT Appeal
(IdPatient, IdPriceList, Diagnosis, `Date`)
VALUES
(3, 1, 'Пісок в нирках', '2021/11/20')

SELECT * FROM TempTablePatient

-- триггер для обновления данных
DELIMITER $$
CREATE TRIGGER AppealUpdate
AFTER UPDATE
ON `Appeal`
FOR EACH ROW BEGIN
	UPDATE `TempTablePatient` 
    SET `Date` = NEW.`Date`
    WHERE `Date`= OLD.Date;
END$$
DELIMITER ;

UPDATE Appeal SET `Date`='2021/11/21'
WHERE IdPatient=3 AND IdPriceList=1
AND Diagnosis='Пісок в нирках'

SELECT * FROM TempTablePatient
