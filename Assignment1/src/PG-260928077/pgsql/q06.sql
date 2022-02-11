-- List the title and release date of movies that were produced in French but not in English. The output
-- should be ordered by the release date and then by the title.

SELECT title, releasedate
FROM movies
         JOIN releaselanguages ON movies.movid = releaselanguages.movid
WHERE language = 'French'
EXCEPT
SELECT title, releasedate
FROM movies
         JOIN releaselanguages ON movies.movid = releaselanguages.movid
WHERE language = 'English'
ORDER BY releasedate, title;