-- List the title, release date and number of reviews of all movies released in 2021. If a movie has no
-- reviews, it should be shown as 0. Name the column with the number of reviews as numreviews. Order the
-- output such that the movies with most reviews are on the top. For movies with same number of reviews,
-- order by their release dates and then by titles.

WITH num_reviews_movie(movid, numreviews) AS
         (
             SELECT m.movid, COUNT(rating) AS numreviews
             FROM review r
                      RIGHT OUTER JOIN movies m ON r.movid = m.movid
             WHERE date_part('year', releasedate) = 2021
             GROUP BY m.movid
         )
SELECT title, releasedate, numreviews
FROM num_reviews_movie nrm
         JOIN movies m ON nrm.movid = m.movid
ORDER BY numreviews DESC, releasedate, title;