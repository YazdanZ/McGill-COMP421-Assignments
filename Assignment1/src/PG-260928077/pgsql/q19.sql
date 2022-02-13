-- Find the movies that fell out of popularity. List the title and release date of all the movies that had
-- an average rating of 7 or above before 2019 but has an average rating of 5 or lower starting 2019 (be careful
-- to take into account movies with no reviews in the later period as 0 rating). Order the output by their release
-- date and then by title.

SELECT title, releasedate
FROM movies
WHERE movid IN
      (
          SELECT movid
          FROM review
          WHERE date_part('year', reviewdate) < 2019
          GROUP BY movid
          HAVING AVG(rating) >= 7
          INTERSECT
          SELECT movies.movid
          FROM (
                   SELECT *
                   FROM review
                   WHERE date_part('year', reviewdate) >= 2019
               ) after2019_reviews
                   RIGHT OUTER JOIN movies ON after2019_reviews.movid = movies.movid
          GROUP BY movies.movid
          HAVING COALESCE(AVG(rating), 0) <= 5
      )
ORDER BY releasedate, title;