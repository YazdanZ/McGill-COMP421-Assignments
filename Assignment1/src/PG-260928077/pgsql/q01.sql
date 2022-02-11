-- List the movie id and title of all movies released on or after the year 2021.
-- The output should be ordered by the movie id.
SELECT movid, title
FROM movies
WHERE releasedate >= '2021-01-01'
ORDER BY movid;
