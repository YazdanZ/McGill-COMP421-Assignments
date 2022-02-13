-- Find the number of Comedy movies that was released in the year 2021. Name the output column nummovies.

SELECT COUNT(*) AS nummovies
FROM moviegenres
         JOIN movies m ON moviegenres.movid = m.movid
WHERE genre = 'Comedy'
  AND date_part('year', releasedate) = 2021;