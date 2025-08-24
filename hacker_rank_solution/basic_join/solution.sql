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

--MEDIUM LEVEL QUESTION
-- Problem: Two tables. Table 1: student_id, name, mark
-- Table 2: Grade, min_mark, max_mark 
-- Present a table with student name, grades, mark. Condition Only names of student grade above 8 must be present, remaining NULL
-- Order should be grade descending, if same grade for grade > 8 order by name alphabetical, for <8 order by marks
-- CONCEPT: Using CASE (If else) JOIN two tables without a foreign key
 
SELECT
    CASE
        WHEN g.grade >= 8 THEN s.name
        ELSE NULL
    END AS name, g.grade, s.marks
    FROM students s
JOIN grades g 
    ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY
    g.grade DESC,
    CASE
        WHEN g.grade >= 8 THEN s.name
    END,
    CASE
        WHEN g.grade < 8 THEN s.marks
    END
