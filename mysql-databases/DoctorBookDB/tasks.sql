
-- TASK 1
-- Вывести ФИО пациентов, обращавшихся на ультразвуковую диагностику
SELECT DISTINCT CONCAT(LastName, ' ', FirstName, ' ', MiddleName) AS PIB FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList
WHERE pl.Name = 'Ультразвукова діагностика'

-- TASK 2
-- Найти пациента, который обращался к врачу минимальное количество раз
SELECT LastName, FirstName, MiddleName AS PIB, 
COUNT(*) AS CNT FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
GROUP BY PIB  
ORDER BY CNT ASC
LIMIT 1

-- TASK 3
-- Найти пациента, обращавшегося к врачу более 3 раз
SELECT LastName, FirstName, MiddleName AS PIB, 
COUNT(*) AS CNT FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
GROUP BY PIB  
HAVING CNT > 3


-- TASK 4
-- Найти пациентов, фамилия которых начинается на "П"
SELECT *  FROM Patient p
WHERE LastName LIKE 'П%'


-- TASK 5
-- Найти фамилии всех пациентов, не обращавшихся на лабораторные обследования
SELECT LastName FROM Patient
WHERE LastName NOT IN
(SELECT DISTINCT LastName FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList
WHERE pl.Name = 'Лабораторні обстеження')


-- TASK 6
-- Найти всех пациентов старше 35 лет и обращавшихся на Иммунологические исследования
SELECT DISTINCT p.* FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList
WHERE pl.Name = 'Імунологічні дослідження'
AND YEAR(CURDATE())-p.Year>35


-- TASK 7
-- Найти фамилии пациентов, которые обращались к врачу после 22 ноября
SELECT DISTINCT p.LastName FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList
WHERE a.Date>'2021/11/22'


-- TASK 8
-- Вывести данные о каждом пациенте и сумме, которую он заплатил врачу за весь период времени обращения
SELECT p.LastName, p.FirstName, p.MiddleName, SUM(pl.Price) Summ FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList
GROUP BY p.LastName, p.FirstName, p.MiddleName


-- TASK 9
-- Найти максимальную плату каждый день, которую вносили пациенты, за период с 22 по 25 ноября включительно
SELECT a.Date, MAX(pl.Price) Summ FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList 
WHERE a.Date>='2021/11/22' AND a.Date<='2021/11/25'
GROUP BY a.Date


-- TASK 10
-- Найти пациентов, у которых диагноз Песок в почках, и дату, когда они обратились к врачу
SELECT DISTINCT p.*, a.Date FROM Patient p
JOIN Appeal a ON a.IdPatient=p.Id
JOIN PriceList pl ON pl.Id=a.IdPriceList 
WHERE a.Diagnosis = 'Пісок в нирках'

