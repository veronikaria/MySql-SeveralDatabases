
-- Представление View
-- Представление ShowPatiensOrderByDate выводит всех пациентов, обращавшихся к врачу
-- дату обращения. Сортировка по дате в нападающем порядке
CREATE VIEW ShowPatiensOrderByDate
AS
SELECT DISTINCT p.*, a.Date FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList 
ORDER BY a.Date DESC


-- Вывести все данные из представления ShowPatiensOrderByDate
-- при условии, пациенты не должны быть старше 40 лет
SELECT * FROM ShowPatiensOrderByDate
WHERE YEAR(CURDATE())-`Year`<=40



-- Вывести все данные из представления ShowPatiensOrderByDate
-- при условии, что дата обращения пациента должна быть
-- или 22 ноября 2021г или 24 ноября 2021г
-- и фамилия пациента должна содержать букву "а"
SELECT * FROM ShowPatiensOrderByDate
WHERE (`Date`='2021/11/22' OR `Date`='2021/11/24')
AND LastName LIKE '%а%'



-- Представление ShowPatiensImunologDosl выводит дату, идентификатор, диагноз и возраст пациента
-- назначен на иммунологические исследования
CREATE VIEW ShowPatiensImunologDosl
AS
SELECT a.Date, p.Id, a.Diagnosis, p.Year FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList 
WHERE pl.Name='Імунологічні дослідження'


-- Вывести все данные из представления ShowPatiensImunologDosl
-- посортировать по возрасту пациента
SELECT * FROM ShowPatiensImunologDosl
ORDER BY `Year`


-- Вывести все данные из представления ShowPatiensImunologDosl
-- при условии, что дата обращения была 22 ноября 2021г.
SELECT * FROM ShowPatiensImunologDosl
WHERE `Date`='2021/11/22'


-- Вывести только идентификаторы пациента и их диагноз из представления ShowPatiensImunologDosl
SELECT Id, Diagnosis  FROM ShowPatiensImunologDosl


-- Проверим обновляемость таблиц представлений.
UPDATE Appeal
SET Diagnosis = 'Менінгіт'
WHERE Id=3

-- Теперь выведем запрос с использованием представления
-- Вывести только идентификаторы пациента и их диагноз из представления ShowPatiensImunologDosl
-- Результат: у пациента изменился диагноз с "подозрением на менингит" на "менингит"
SELECT Id, Diagnosis  FROM ShowPatiensImunologDosl
