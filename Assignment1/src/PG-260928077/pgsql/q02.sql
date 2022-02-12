-- Find the user id of all the users who have reviewed the movie (title) Casablanca. The output should
-- be ordered by the user id. You may assume that there is only one movie with this title.

SELECT userid
FROM movies
         JOIN review ON movies.movid = review.movid
WHERE title = 'Casablanca'
ORDER BY userid;

-- Solution 2:
-- SELECT userid
-- FROM review,
--      movies
-- WHERE movies.movid = review.movid
--   AND title = 'Casablanca'
-- ORDER BY userid;