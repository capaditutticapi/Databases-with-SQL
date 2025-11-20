-- *** The Lost Letter ***

-- -- Subquery: Use Anneke's 'from' address to find all packages sent from that address, and all info from these packages:
-- SELECT "id", "to_address_id", "contents" FROM "packages" WHERE "from_address_id" = (SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue');
-- -- Now I can see 4 packages Anneke has sent. I know the missing one has "contents" = "Congratulatory letter", so lets get this specific package id
-- SELECT "id" FROM "packages" WHERE "contents" = "Congratulatory letter" AND "from_address_id" = (SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue');
-- -- Now to find current Location of letter, use scans table, using id found above to find all info of our missing letter:
-- SELECT * FROM "scans" WHERE "package_id" = (SELECT "id" FROM "packages" WHERE "contents" = "Congratulatory letter" AND "from_address_id" = (SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue'));
-- -- lets find the address id where the package was last scanned, ie action = 'Drop'
-- SELECT "address_id" FROM "scans" WHERE "action" = 'Drop' AND "package_id" = (SELECT "id" FROM "packages" WHERE "contents" = "Congratulatory letter" AND "from_address_id" = (SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue'));
-- -- Now to find the address and type, associated with this address id, back to addresses table:

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

-- -- Find parcels with a null from address:
-- SELECT * FROM "packages" WHERE "from_address_id" IS NULL;
-- -- contents = 'Duck debugger'. now use the to address info to find current addy
-- SELECT "to_address_id" FROM "packages" WHERE "from_address_id" IS NULL AND "contents" = 'Duck debugger';
-- -- find atest location of package, where action = drop and package id has been found above
-- SELECT "address_id" FROM "scans" WHERE "action" = 'Drop' AND "package_id" = (SELECT "id" FROM "packages" WHERE "from_address_id" IS NULL AND "contents" = 'Duck debugger');
-- -- now we have the drop address id, find the address:
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

-- -- using the from address id, find content and to address info :
-- SELECT * FROM "packages" WHERE "from_address_id" = (SELECT "id" FROM "addresses" WHERE "address" = '109 Tileston Street');
-- -- find latest update on package with scans table
-- SELECT * FROM "scans" WHERE "package_id" = (SELECT "id" FROM "packages" WHERE "from_address_id" = (SELECT "id" FROM "addresses" WHERE "address" = '109 Tileston Street')) ORDER BY "timestamp" DESC;
-- -- we can see it was picked up, delivered, and picked up again. now find driver who has it in drivers table. using driver_id:
-- -- usinf order by DESC to find the latest scan of the package. or else it would default to the first in the list which is the first scan
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
