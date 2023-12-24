
-- Task 1. Get empid, firstname, lastname, country, region, city of all employees from USA.

SELECT 
    Employees.BusinessEntityID AS empid, 
    Employees.FirstName, 
    Employees.LastName, 
    Employees.CountryRegionName AS country, 
    Employees.StateProvinceName AS region, 
    Employees.City
FROM Employees
WHERE Employees.CountryRegionName = 'United States';


-- ========================================================================================


-- Task 2. Get the number of employees for each specialty.

SELECT 
    JobTitle AS Specialty, 
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY JobTitle;

-- =========================================================================================

-- Task 3. Count the number of people for each name.

SELECT 
    FirstName, 
    COUNT(*) AS PersonCount
FROM Employees
GROUP BY FirstName;

-- =========================================================================================

-- Task 4. Get the most common name.

SELECT TOP 1 
    FirstName, 
    COUNT(*) AS NameCount
FROM Employees
GROUP BY FirstName
ORDER BY NameCount DESC;

-- =========================================================================================

-- Task 5. Get the least common name.

SELECT TOP 1 
    FirstName, 
    COUNT(*) AS NameCount
FROM Employees
GROUP BY FirstName
ORDER BY NameCount ASC;

-- =========================================================================================

-- Task 6. Get the top 5 cities where the most workers are.

SELECT TOP 5
    City,
    COUNT(*) AS WorkerCount
FROM Employees
GROUP BY City
ORDER BY WorkerCount DESC;

-- =========================================================================================

-- Task 7. Get the top 5 cities, which have the most unique specialties.

SELECT TOP 5
    City,
    COUNT(DISTINCT JobTitle) AS UniqueSpecialtyCount
FROM Employees
GROUP BY City
ORDER BY UniqueSpecialtyCount DESC;

-- =========================================================================================

-- Task 8. Issue mailing addresses for emailing to all employees who started working on 1/01/2012.

SELECT 
    FirstName,
    LastName,
    EmailAddress,
    AddressLine1,
    AddressLine2,
    City,
    StateProvinceName,
    PostalCode,
    CountryRegionName
FROM Employees
WHERE [StartDate] = '2012-01-01';

-- ===========================================================================================

-- Task 9. Issue statistics in what year how many employees were employed.

SELECT 
    YEAR([StartDate]) AS EmploymentYear,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY YEAR([StartDate])
ORDER BY EmploymentYear;

-- ===========================================================================================

-- Task 10. Issue statistics in which year how many workers in which countries were employed.

SELECT 
    YEAR([StartDate]) AS EmploymentYear,
    CountryRegionName AS Country,
    COUNT(*) AS WorkerCount
FROM Employees
GROUP BY YEAR([StartDate]), CountryRegionName
ORDER BY EmploymentYear, Country;

-- ===========================================================================================

-- Task 11. Refresh the Employees table by adding data from the History table to the EndDate column.

UPDATE Employees
SET Employees.EndDate = History.EndDate
FROM Employees
JOIN History ON Employees.BusinessEntityID = History.BusinessEntityID;

-- ===========================================================================================

-- Task 12. Issue statistics on how many employees in which year they left.

SELECT 
    YEAR([EndDate]) AS LeavingYear,
    COUNT(*) AS EmployeeCount
FROM Employees
WHERE [EndDate] IS NOT NULL
GROUP BY YEAR([EndDate])
ORDER BY LeavingYear;


-- ============================================================================================

-- Task 13. Issue the number of employees who have worked less than a year.

SELECT 
    COUNT(*) AS EmployeeCount
FROM Employees
WHERE DATEDIFF(MONTH, StartDate, ISNULL(EndDate, GETDATE())) < 12;