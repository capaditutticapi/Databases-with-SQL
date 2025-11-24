-- 1
SELECT "name", "city"
FROM "schools"
WHERE "type" = "Public School";

-- 2
SELECT "name"
FROM "districts"
WHERE "name"
LIKE '%(non-op)';

-- 3
SELECT AVG("per_pupil_expenditure")
AS "Average District Per-Pupil Expenditure"
FROM "expenditures";

-- 4
SELECT COUNT(*), "city"
FROM "schools"
WHERE "type" = "Public School"
GROUP BY "city"
ORDER BY COUNT(*) DESC, "city"
LIMIT 10;

-- 5
SELECT COUNT (*), "city"
FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
HAVING COUNT(*) < 4
ORDER BY COUNT(*) DESC, "city";

-- 6
SELECT "name"
FROM "schools"
WHERE "id" IN
    (SELECT "school_id"
    FROM "graduation_rates"
    WHERE "graduated" = 100);

-- 7
SELECT "name"
FROM "schools"
WHERE "district_id" IN
    (SELECT "id"
    FROM "districts"
    WHERE "name" = 'Cambridge');

-- 8
SELECT "name", "pupils"
FROM "districts"
JOIN "expenditures"
ON "districts"."id" = "expenditures"."district_id";

-- 9
SELECT "name"
FROM "districts"
JOIN "expenditures"
ON "districts"."id" = "expenditures"."district_id"
WHERE "pupils" = (
    SELECT MIN("pupils")
    FROM "expenditures"
);

-- Alternative way:
SELECT "name"
FROM "districts"
WHERE "id" IN (
    SELECT "district_id"
    FROM "expenditures"
    WHERE "pupils" = (
        SELECT MIN("pupils")
        FROM "expenditures"
    )
);

-- 10 
SELECT "d"."name", "e"."per_pupil_expenditure"
FROM "districts" AS "d"
JOIN "expenditures" AS "e"
ON "d"."id" = "e"."district_id"
WHERE "d"."type" = 'Public School District'
ORDER BY "e"."per_pupil_expenditure" DESC
LIMIT 10;

-- 11
SELECT s.name AS 'School Name', e.per_pupil_expenditure, g.graduated AS 'Graduation Rate'
FROM schools AS s
JOIN expenditures AS e ON s.district_id = e.district_id
JOIN graduation_rates AS g ON s.id = g.school_id
ORDER BY e.per_pupil_expenditure DESC, s.name;

-- 12
SELECT d.name, s.exemplary, e.per_pupil_expenditure
FROM districts AS d
JOIN staff_evaluations AS s ON d.id = s.district_id
JOIN expenditures AS e ON d.id = e.district_id
WHERE d.type = 'Public School District'
    AND s.exemplary > (
        SELECT AVG(exemplary)
        FROM staff_evaluations
    )
    AND e.per_pupil_expenditure > (
        SELECT AVG(per_pupil_expenditure)
        FROM expenditures
    )
ORDER BY s.exemplary DESC, e.per_pupil_expenditure DESC
;

-- 13
SELECT sc.name, sc.city, g.dropped
FROM schools AS sc
JOIN graduation_rates AS g ON sc.id = g.school_id
ORDER BY g.dropped DESC
LIMIT 15
