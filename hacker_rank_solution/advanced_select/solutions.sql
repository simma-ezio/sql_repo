--EASY level
/*
Equilateral: It's a triangle with 3 sides of equal length.
Isosceles: It's a triangle with 2 sides of equal length.
Scalene: It's a triangle with 3 sides of differing lengths.
Not A Triangle: If sum of any two side is not greater than third side

Table: a b c - sides of triangle
*/
SELECT 
    CASE
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR A = C THEN 'Isosceles'
        ELSE 'Scalene'
    END AS TRIANGLE_TYPE
FROM
    TRIANGLES

/*
Query an alphabetically ordered list of all names in OCCUPATIONS,
immediately followed by the first letter of each profession in parentheses.
For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

Also, query the count of each occupation in OCCUPATIONS,
sorted by ascending count and then alphabetically,
outputting:
'There are a total of [count] [occupation]s.'
where occupation is lowercase.
There are a total of 2 doctors.
Concept: string handling
*/
-- First query: Names with occupation initials
SELECT CONCAT(NAME, '(', LEFT(OCCUPATION, 1), ')') AS formatted_name
FROM OCCUPATIONS
ORDER BY NAME;

-- Second query: Count of each occupation
SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(OCCUPATION), 's.') AS output
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY COUNT(*) ASC, OCCUPATION ASC;
