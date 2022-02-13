-- List the title and release date of all movies with less than 2 reviews (make sure to take into account
-- the movies with zero reviews). Order the output by release date and then by title.

SELECT title, releasedate
FROM movies
WHERE movid IN (
    SELECT m.movid
    FROM movies m
             LEFT OUTER JOIN review r on m.movid = r.movid
    GROUP BY m.movid
    HAVING COUNT(r.rating) < 2
)
ORDER BY releasedate, title;

-- Solution 2:
-- WITH countmovie(movid, count) AS
--          (
--              SELECT movid, COUNT(*)
--              FROM review
--              GROUP BY movid
--          )
-- SELECT title, releasedate
-- FROM movies
--          LEFT OUTER JOIN countmovie ON countmovie.movid = movies.movid
-- WHERE movies.movid NOT IN (
--     SELECT movid
--     FROM countmovie
--     WHERE count >= 2
-- )
-- ORDER BY releasedate, title;