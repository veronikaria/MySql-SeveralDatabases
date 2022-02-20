
-- Процедура ProcDiagnosisByName выводит диагнозы и даты, когда поставлены
-- данные диагнозы определенного пациента, ФИО пациента – входные параметры
DELIMITER $$
CREATE PROCEDURE `ProcDiagnosisByName`(
	IN LastName VARCHAR(30), 
    IN FirstName VARCHAR(30),
    IN MiddleName VARCHAR(30)
)
 BEGIN
SELECT DISTINCT a.Diagnosis, a.Date FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
WHERE p.LastName=LastName AND 
p.FirstName=FirstName AND 
p.MiddleName=MiddleName ;
 END$$
DELIMITER ;

CALL ProcDiagnosisByName('Іванов', 'Іван', 'Іванович')

-- Функция FuncCountPatientsByDate возвращает количество пациентов
-- которые посетили врача в определенный день
DELIMITER $$
CREATE FUNCTION `FuncCountPatientsByDate`(`date` DATE)
RETURNS INT
DETERMINISTIC
 BEGIN
 DECLARE cnt INT;
 SET cnt = (SELECT COUNT(*) FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id 
WHERE a.`Date`=`date`);
RETURN (cnt);
 END$$
DELIMITER ;


SELECT FuncCountPatientsByDate('2021/11/21')  as cnt

SELECT FuncCountPatientsByDate('2021/11/20')  as cnt

