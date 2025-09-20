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


-- Write a SQL query to find hackers who got full scores on more than one challenge.
-- Return their hacker_id and name, sorted by:
--Number of full-score challenges (descending)
--hacker_id (ascending) if tied.

--Use the following tables:
--Hackers(hacker_id, name)
--Difficulty(difficulty_level, score) — max score per difficulty
--Challenges(challenge_id, difficulty_level)
--Submissions(hacker_id, challenge_id, score) — hacker submissions
--Only consider full scores (i.e., score = max score)


SELECT 
    s.hacker_id,
    h.name
FROM Submissions s
JOIN Challenges c ON s.challenge_id = c.challenge_id
JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
JOIN Hackers h ON s.hacker_id = h.hacker_id
WHERE s.score = d.score  -- full score
GROUP BY s.hacker_id, h.name
HAVING COUNT(DISTINCT s.challenge_id) > 1
ORDER BY COUNT(DISTINCT s.challenge_id) DESC, s.hacker_id ASC;

--Tables:
-- Wands: id (wand id), code (wand code), coins_needed (cost), power (wand quality)
-- Wands_Property: code (wand code), age (wand age), is_evil (0 = not evil, 1 = evil)

--Task:
-- Find non-evil wands (is_evil = 0) by joining Wands and Wands_Property on code.
-- For each unique (age, power), select the wand with minimum coins_needed.
-- Output id, age, coins_needed, and power sorted by descending power, then descending age.

SELECT w.id, p.age, w.coins_needed, w.power
FROM Wands AS w
JOIN Wands_Property AS p ON w.code = p.code
WHERE w.coins_needed = (
    SELECT MIN(coins_needed)
    FROM Wands w2
    INNER JOIN Wands_Property p2 ON w2.code = p2.code
    WHERE p2.is_evil = 0 AND p.age = p2.age AND w.power = w2.power
)
ORDER BY w.power DESC, p.age DESC;


/*
Tables:
- Hackers: hacker_id (id), name
- Challenges: challenge_id (id), hacker_id (creator's id)

Task:
Find each hacker’s total challenges created.
Exclude hackers with duplicate challenge counts unless the count is the maximum.
Display hacker_id, name, and total challenges.
Sort by total challenges (desc), then hacker_id.
*/
with cte as
(
  select h.hacker_id, h.name, count(challenge_id) as numb
  from  hackers h 
    inner join challenges c 
    on h.hacker_id = c.hacker_id
  group by h.name, h.hacker_id
)

select  hacker_id, name, numb
from cte
where numb IN
(
  select   numb
  from cte
  group by numb
  having (count(numb) <  2)  or (numb = (select  max(numb) from cte))
)

order by numb desc, hacker_id;


/*
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score.
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id.
Exclude all hackers with a total score of  from your result.
Tables:
- Hackers: hacker_id (id), name
- SUBMISSIONS: submission_id, hacker_id, challenge_id, score
*/
SELECT  h.HACKER_ID, h.NAME, SUM(fs.MAX_SCORES) AS TOTAL_SCORE
FROM 
    (SELECT HACKER_ID,CHALLENGE_ID, MAX(SCORE) AS MAX_SCORES
        FROM SUBMISSIONS
        GROUP BY HACKER_ID, CHALLENGE_ID
        HAVING MAX(SCORE) != 0) AS fs
JOIN 
    HACKERS h ON fs.HACKER_ID = h.HACKER_ID
GROUP BY h.HACKER_ID, h.NAME
ORDER BY TOTAL_SCORE DESC, h.HACKER_ID
