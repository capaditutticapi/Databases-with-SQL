-- 1
SELECT "japanese_title", "english_title" FROM "views";

-- 2
SELECT "average_color"
FROM "views"
WHERE "artist" = 'Hokusai' AND "english_title" LIKE '%river%'

-- 3
SELECT COUNT(*) FROM "views" WHERE "artist" = 'Hokusai' AND "english_title" LIKE '%Fuji%';

-- 4
SELECT COUNT(*)
FROM "views"
WHERE "artist" = 'Hiroshige' AND "english_title" LIKE '%Eastern Capital%';

-- 5
SELECT "contrast" FROM "views" WHERE "artist" = 'Hokusai' ORDER BY "contrast" DESC LIMIT 1;

-- 6
SELECT ROUND(AVG("entropy"),2) FROM "views" WHERE "artist" = 'Hiroshige';

-- 7
SELECT "english_title" FROM "views" WHERE "artist" = 'Hiroshige' ORDER BY "brightness" DESC LIMIT 5

-- 8
SELECT "english_title" FROM "views" WHERE "artist" = 'Hokusai' ORDER BY "contrast" LIMIT 5

-- 9
SELECT "english_title", "artist" FROM "views" ORDER BY "brightness" DESC LIMIT 1

-- 10
SELECT "english_title", "brightness" AS 'Hiroshiges 10 Brightest Views'
FROM "views"
WHERE "artist" = 'Hiroshige'
ORDER BY "brightness"
DESC LIMIT 10;
