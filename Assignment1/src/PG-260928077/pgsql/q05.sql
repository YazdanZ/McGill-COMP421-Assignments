-- Give the list of movies (titles) and release dates of movies released in the year 2021 that falls into both
-- the genres Comedy and Sci-Fi (i.e., a movie should be part of both the genres and not just one). Order the
-- output by release date and then by titles.

WITH movie_genre_2021(title, releasedate, genre) AS
         (
             SELECT title, releasedate, genre
             FROM movies
                      JOIN moviegenres on movies.movid = moviegenres.movid
             WHERE date_part('year', releasedate) = 2021
         )
SELECT title, releasedate
FROM movie_genre_2021
WHERE genre = 'Comedy'
INTERSECT
SELECT title, releasedate
FROM movie_genre_2021
WHERE genre = 'Sci-Fi'
ORDER BY releasedate, title;

-- Solution 2:
-- SELECT title, releasedate
-- FROM movies
--          JOIN moviegenres ON movies.movid = moviegenres.movid
-- WHERE date_part('year', releasedate) = 2021
--   AND genre = 'Comedy'
-- INTERSECT
-- SELECT title, releasedate
-- FROM movies
--          JOIN moviegenres ON movies.movid = moviegenres.movid
-- WHERE date_part('year', releasedate) = 2021
--   AND genre = 'Sci-Fi'
-- ORDER BY releasedate, title;

-- Solution 3:
-- SELECT m1.title, m1.releasedate
-- FROM movies m1,
--      movies m2,
--      moviegenres g1,
--      moviegenres g2
-- WHERE (m1.movid = g1.movid AND g1.genre = 'Comedy')
--   AND (m2.movid = g2.movid AND g2.genre = 'Sci-Fi')
--   AND m1.movid = m2.movid
--   AND date_part('year', m1.releasedate) = 2021
-- ORDER BY m1.releasedate, m1.title;