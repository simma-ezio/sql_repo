-- Problem: Select countries in USA with population > 100000
-- Concept: WHERE clause, basic filtering
SELECT * FROM CITY
WHERE population>100000 AND countrycode="USA"

  
-- Problem: Query Names of City in USA with population > 120000
-- Concept: WHERE clause, basic filtering
SELECT NAME FROM CITY
WHERE COUNTRYCODE="USA" AND POPULATION > 120000

-- Problem: Query Names of Distinct City whose city ID is even number
SELECT DISTINCT CITY FROM STATION
WHERE ID % 2 = 0

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
-- Concept Aggregate functions in select statement
SELECT COUNT(CITY)-COUNT(DISTINCT CITY)FROM STATION

-- Problem: Find the cities in the STATION table with the shortest and longest names.
-- If multiple cities have the same length, return the one that comes first alphabetically.
-- Also return the length of the city names.
-- Output: CITY name and its length for both the shortest and longest CITY names.
-- Concept: union, ordering query and limiting 
(
  SELECT CITY, LENGTH(CITY) AS name_length
  FROM STATION
  ORDER BY LENGTH(CITY) ASC, CITY ASC
  LIMIT 1
)
UNION
(
  SELECT CITY, LENGTH(CITY) AS name_length
  FROM STATION
  ORDER BY LENGTH(CITY) DESC, CITY ASC
  LIMIT 1

-- Problem: Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
-- Concept: finding or searching by pattern using case insensitive WHERE methods: LIKE ABC%, %ABC, ABC_, _ABC
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE 'A%' OR CITY LIKE "E%"
OR CITY LIKE "I%" OR CITY LIKE "O%"
OR CITY LIKE "U%"

-- Problem: Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE "%a" OR CITY LIKE "%e" OR
CITY LIKE "%i" OR CITY LIKE "%o" OR
CITY LIKE "%u"
  
