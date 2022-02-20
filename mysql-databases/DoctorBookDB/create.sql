CREATE DATABASE DoctorBook

USE DoctorBook

-- Таблица Пациент
-- LastName – фамилия пациента
-- FirstName - имя пациента
-- MiddleName - отчество пациента
-- Year - год рождения пациента
CREATE TABLE Patient(
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
	`Year` INT 
)

-- Таблица Прейскурант
-- Name - название назначения
-- Price - стоимость
CREATE TABLE PriceList(
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(100) NOT NULL,
    Price DECIMAL(15,2) NOT NULL
)

-- Таблица Обращения
-- IdPatient – идентификатор пациента
-- IdPriceList – идентификатор назначения
-- Diagnosis – диагноз
-- Date - дата обращения
CREATE TABLE Appeal(
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    IdPatient INT NOT NULL,
    IdPriceList INT NOT NULL,
	Diagnosis VARCHAR(100) NOT NULL,
    `Date` DATE NOT NULL,
    FOREIGN KEY (IdPatient)  REFERENCES Patient (Id),
    FOREIGN KEY (IdPriceList)  REFERENCES PriceList (Id)
)

