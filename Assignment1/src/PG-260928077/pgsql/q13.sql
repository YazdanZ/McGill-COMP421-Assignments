-- List the title and release date of all movies with the maximum number (count) of reviews. Order the
-- output by release date and then by title.

WITH countmovie(movid, count) AS
         (
             SELECT m.movid, COUNT(rating) AS count
             FROM review
                      RIGHT OUTER JOIN movies m ON review.movid = m.movid
             GROUP BY m.movid
         )
SELECT title, releasedate
FROM movies
WHERE movid IN (
    SELECT movid
    FROM countmovie
    WHERE count = (SELECT MAX(count) FROM countmovie)
)
ORDER BY releasedate, title;