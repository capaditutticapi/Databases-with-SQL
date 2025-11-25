-- 1
SELECT year, ROUND(AVG(salary),2)
FROM salaries
GROUP BY year
ORDER BY year DESC;

-- 2
SELECT year, salary
FROM salaries
WHERE player_id IN (
    SELECT id
    FROM players
    WHERE first_name = 'Cal'
    AND last_name = 'Ripken'
)
ORDER BY year DESC;

-- 3
SELECT year, HR
FROM performances
WHERE player_id = (
    SELECT id
    FROM players
    WHERE first_name = 'Ken'
    AND last_name = 'Griffey'
    AND birth_year = 1969
)
ORDER BY year DESC;

-- 4
SELECT p.first_name, p.last_name, s.salary
FROM players AS p
JOIN salaries AS s ON p.id = s.player_id
WHERE s.year = 2001
ORDER BY s.salary, p.first_name , p.last_name, p.id
LIMIT 50;

-- 5
SELECT name
FROM teams
WHERE id IN (
    SELECT team_id
    FROM performances
    WHERE player_id IN (
        SELECT id
        FROM players
        WHERE first_name = 'Satchel'
        AND last_name = 'Paige'
    )
);

-- 6
SELECT t.name, SUM(p.H) AS 'total hits'
FROM performances AS p
JOIN teams AS t ON p.team_id = t.id
WHERE p.year = 2001
GROUP BY t.name
ORDER BY SUM(p.H) DESC
LIMIT 5;

-- 7 
SELECT p.first_name, p.last_name
FROM players AS p
JOIN salaries AS s ON p.id = s.player_id
WHERE s.salary = (
    SELECT MAX(salary)
    FROM salaries
);

-- 8
SELECT salary
FROM salaries
WHERE year = 2001
AND player_id = (
    SELECT player_id
    FROM performances
    WHERE HR = (
        SELECT MAX(HR)
        FROM performances
        WHERE year = 2001
    )
);

-- 9
SELECT teams.name, ROUND(AVG(salaries.salary),2) AS 'Average Salary'
FROM teams
JOIN salaries ON teams.id = salaries.team_id
WHERE salaries.year = 2001
GROUP BY teams.name
ORDER BY AVG(salaries.salary)
LIMIT 5;

-- 10
SELECT pl.first_name, pl.last_name, s.salary, pe.HR, pe.year
FROM players AS pl
JOIN salaries AS s ON pl.id = s.player_id
JOIN performances AS pe ON pl.id = pe.player_id AND s.year = pe.year
ORDER BY pl.id, s.year DESC, pe.HR DESC, s.salary DESC;

-- 11
SELECT pl.first_name, pl.last_name, (SUM(s.salary)/pe.H) AS "Dollars Per Hit"
FROM players AS pl
    JOIN salaries AS s ON pl.id = s.player_id
    JOIN performances AS pe ON pl.id = pe.player_id
WHERE pe.H != 0
    AND s.year = 2001
    AND s.year = pe.year
GROUP BY pl.id
ORDER BY "Dollars Per Hit" , pl.first_name, pl.last_name
LIMIT 10;

-- 12
SELECT first_name, last_name
FROM players
WHERE id IN (
    SELECT id
    FROM (
        SELECT pl.id, SUM(s.salary)/pe.RBI AS 'Dollars per Runs Batted In'
        FROM players AS pl
            JOIN salaries AS s ON pl.id = s.player_id
            JOIN performances AS pe ON pl.id = pe.player_id
        WHERE s.year = pe.year
            AND pe.RBI != 0
            AND pe.year = 2001
        GROUP BY pl.id
        ORDER BY "Dollars per Runs Batted In", pl.id, pl.first_name
        LIMIT 10
    )

    INTERSECT

    SELECT id
    FROM (
        SELECT pl.id, (SUM(s.salary)/pe.H) AS "Dollars Per Hit"
        FROM players AS pl
            JOIN salaries AS s ON pl.id = s.player_id
            JOIN performances AS pe ON pl.id = pe.player_id
        WHERE pe.H != 0
            AND s.year = 2001
            AND s.year = pe.year
        GROUP BY pl.id
        ORDER BY "Dollars Per Hit" , pl.first_name, pl.last_name
        LIMIT 10
    )
)
ORDER BY id;


