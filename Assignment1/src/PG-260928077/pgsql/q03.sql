-- List the user id of all the users who gave a favourable review (rating 7 and above) for the 1959 version
-- of the movie (title) Ben-Hur but did not review or gave an unfavourable review (rating 4 and below) for the
-- 2016 version of the movie. The output should be ordered by the user id.

SELECT userid
FROM review
         JOIN movies m ON m.movid = review.movid
WHERE title = 'Ben-Hur'
  AND date_part('year', releasedate) = 1959
  AND rating >= 7
EXCEPT
SELECT userid
FROM review
         JOIN movies m2 ON m2.movid = review.movid
WHERE title = 'Ben-Hur'
  AND date_part('year', releasedate) = 2016
  AND rating > 4
ORDER BY userid;