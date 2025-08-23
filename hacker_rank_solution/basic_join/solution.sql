-- Problem: Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
-- Concept: JOIN, TABLE_NAME.ATTRIBUTES way to call the column in a table when more than 1 table is there
SELECT SUM(CITY.Population)
FROM CITY
 INNER JOIN COUNTRY
    ON CITY.CountryCode = COUNTRY.Code
WHERE COUNTRY.Continent = 'Asia';

-- Problem: Given the CITY and COUNTRY tables, query name of cities where the CONTINENT is 'Africa'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
SELECT CITY.Name FROM CITY
INNER JOIN COUNTRY
    ON CITY.CountryCode = COUNTRY.Code
WHERE COUNTRY.Continent = 'Africa'

-- Problem: query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
-- CONCEPT: Difference between ROUND and FLOOR in SQL
-- FLOOR(5.8) = 5; ROUND(5.8) = 6
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) FROM CITY
INNER JOIN COUNTRY
    ON CITY.CountryCode=COUNTRY.Code
GROUP BY COUNTRY.Continent
