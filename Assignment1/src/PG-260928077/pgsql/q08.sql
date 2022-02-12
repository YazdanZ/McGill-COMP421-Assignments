-- List the name and email address of all the users who have written a review for a movie that was
-- released ONLY in French (they are free to write reviews for any other movies). Order the output by the
-- email.

SELECT DISTINCT uname, email
FROM review
         JOIN users u ON review.userid = u.userid
WHERE movid IN (
    SELECT movid
    FROM releaselanguages
    WHERE language = 'French'
    EXCEPT
    SELECT movid
    FROM releaselanguages
    WHERE language <> 'French'
)
ORDER BY email;

-- Solution 2:
-- WITH num_languages (movid, count) AS (
--     SELECT r.movid, COUNT(r.movid)
--     FROM movies
--              JOIN releaselanguages r on movies.movid = r.movid
--     GROUP BY r.movid
-- )
-- SELECT DISTINCT uname, email
-- FROM review
--          JOIN users u on review.userid = u.userid
-- WHERE movid IN (
--     SELECT rl.movid
--     FROM num_languages nl
--              JOIN releaselanguages rl ON rl.movid = nl.movid
--     WHERE count = 1
--       AND language = 'French'
-- )
-- ORDER BY email;