-- List the movie id and title of all movies released on or after the year 2021.
-- The output should be ordered by the movie id.

-- movid is a primary key, no need to put
-- constraint on duplicates in our query.
SELECT movid, title
FROM movies
WHERE releasedate >= '2021-01-01'
ORDER BY movid;

-- Solution 2:
-- SELECT movid, title
-- FROM movies
-- WHERE date_part('year', releasedate) >= 2021
-- ORDER BY movid;