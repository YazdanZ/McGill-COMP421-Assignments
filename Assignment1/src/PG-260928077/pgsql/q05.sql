-- Give the list of movies (titles) and release dates of movies released in the year 2021 that falls into both
-- the genres Comedy and Sci-Fi (i.e., a movie should be part of both the genres and not just one). Order the
-- ouput by release date and then by titles.
SELECT title, releasedate
FROM movies
         JOIN moviegenres ON movies.movid = moviegenres.movid
WHERE date_part('year', releasedate) = 2021
  AND genre = 'Comedy'
INTERSECT
SELECT title,releasedate
FROM movies
         JOIN moviegenres ON movies.movid = moviegenres.movid
WHERE date_part('year', releasedate) = 2021
  AND genre = 'Sci-Fi'
ORDER BY releasedate, title;