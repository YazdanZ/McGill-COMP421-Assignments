-- Find the user id of all the users who have reviewed the movie (title) Casablanca. The output should
-- be ordered by the user id. You may assume that there is only one movie with this title.
SELECT userid
FROM review
         JOIN movies m ON m.movid = review.movid
WHERE title = 'Casablanca'
ORDER BY userid;

-- Alternatively we could query as such:
-- SELECT userid
-- FROM review,
--      movies
-- WHERE review.movid = movies.movid
--   AND movies.title = 'Casablanca'
-- ORDER BY userid;