-- *** The Lost Letter ***
SELECT "address", "type"
FROM "addresses"
WHERE "id" =
    (SELECT "address_id"
    FROM "scans"
    WHERE "action" = 'Drop' AND "package_id" =
        (SELECT "id"
        FROM "packages"
        WHERE "contents" = "Congratulatory letter" AND "from_address_id" =
            (SELECT "id"
            FROM "addresses"
            WHERE "address" = '900 Somerville Avenue')));

-- *** The Devious Delivery ***
SELECT "address", "type"
FROM "addresses"
WHERE "id" =
    (SELECT "address_id"
    FROM "scans"
    WHERE "action" = 'Drop'
    AND "package_id" =
        (SELECT "id"
        FROM "packages"
        WHERE "from_address_id" IS NULL
        AND "contents" = 'Duck debugger'));

-- *** The Forgotten Gift ***
SELECT "name"
FROM "drivers"
WHERE "id" =
    (SELECT "driver_id"
    FROM "scans"
    WHERE "package_id" =
        (SELECT "id"
        FROM "packages"
        WHERE "from_address_id" =
            (SELECT "id"
            FROM "addresses"
            WHERE "address" = '109 Tileston Street'))
    ORDER BY "timestamp" DESC);
