--EASY Problem
-- Problem: Find the number of cities with population > 100000
SELECT COUNT(*) FROM CITY
WHERE Population > 100000

-- Problem: Query the total population of all cities in CITY where District is California.
SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT LIKE 'CALIFORNIA'
SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT LIKE 'CALIFORNIA'

-- Problem: Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT ROUND(AVG(POPULATION)) FROM CITY
SELECT MAX(POPULATION)-MIN(POPULATION) FROM CITY

-- Problem: While calculating the average monthly salaries for all employees in the EMPLOYEES table, keyboard's 0 key was broken until after completing the calculation.
-- help finding the difference between miscalculation (using salaries with any zeros removed), and the actual average salary.
-- Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer.
-- Concept: REPLACE --> Used to replace all zero with '' but it converts the integer to string (note: it does for all instances of 0 eg: 2008 to 28)
--        : CAST AS UNSIGNED --> Converts the string type to UNSIGNED integer (non negative values)
--        : CEIL ---> Round the integer to CEILING (eg 3.1 to 4, 3.5 to 4, 3.8 to 4 always to upper)  
SELECT 
    CEIL(AVG(salary) - AVG(CAST(REPLACE(salary, '0', '') AS UNSIGNED))) AS error_amount
FROM employees;

-- Problem:  employee's total earnings = salary * month
--        : Write a query to find the maximum total earnings for all employees and the total number of employees who have maximum total earnings
-- LITTLE BIT CONFUSING
SELECT (MONTHS * SALARY) AS EARNS, COUNT(*)
FROM EMPLOYEE
WHERE (MONTHS * SALARY) = (SELECT MAX(MONTHS * SALARY) FROM EMPLOYEE)
GROUP BY EARNS;
-- The WHERE Part is important it returns only max earning a single output, Notice the GROUP BY
-- ALTERNATE SOLUTION
SELECT MAX(SALARY*MONTHS), COUNT(*)
FROM EMPLOYEE
WHERE (SALARY*MONTHS)>= (SELECT MAX(SALARY*MONTHS)FROM EMPLOYEE)

-- Problem: The sum of all values in LAT_N rounded to a scale of 2 decimal places. TABLE: STATION
SELECT ROUND(SUM(LAT_N),2), ROUND(SUM(LONG_W),2) FROM STATION


--Problem: Find Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.
-- latitude and longtidue are separate column
SELECT ROUND(LONG_W,4) FROM STATION 
WHERE LAT_N < 137.2345
ORDER BY LAT_N DESC
LIMIT 1
--ALTERNATE 
SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N = (
    SELECT MAX(LAT_N) 
    FROM STATION
    WHERE LAT_N < 137.2345);

--MEDIUM LEVEL PROBLEMS
-- Consider p1(a,b)  and p2(c,d) to be two points on a 2D plane.
 -- a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 -- b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 -- c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 -- d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
-- Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.
SELECT ROUND(ABS(MAX(LAT_N)-MIN(LAT_N)) + ABS(MAX(LONG_W)- MIN(LONG_W)),4) FROM Station

-- For same case find the Eucledian norm between the two points
SELECT ROUND( 
    SQRT(
            POWER(MAX(LAT_N)-MIN(LAT_N),2) + POWER(MAX(LONG_W)- MIN(LONG_W),2)
            )
                ,4) FROM Station

-- A median is defined as a number separating the higher half of a data set from the lower half.
-- Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places. 
-- Concept: WINDOW Function, FLOOR (4.6 = 4 )  CEIL ceiling (4.2 = 5)

SELECT ROUND(AVG(LAT_N), 4) AS median_lat
FROM (
    SELECT LAT_N,
           ROW_NUMBER() OVER (ORDER BY LAT_N) AS rn,
           COUNT(*) OVER () AS total_rows
    FROM STATION
) AS ordered
WHERE rn IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));





