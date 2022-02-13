-- List the title of the movie and the number of reviews for the latest (release date) movie (There could
-- possibly be more than one movie that qualifies). Movies with no reviews yet should not be ignored in the
-- output. Name the number of reviews as numreviews. Order the output based on the title of the movie.

SELECT title, COUNT(rating) AS numreviews
FROM review r
         RIGHT OUTER JOIN movies m ON r.movid = m.movid
WHERE releasedate = (
    SELECT MAX(releasedate)
    FROM movies
)
GROUP BY title
ORDER BY title;