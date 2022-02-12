-- List all the movies (title), release date and the ratings for the reviews done by the user whose email is
-- talkiesdude@movieinfo.com. The output should be ordered with the highest ratings on top. If two movies
-- have the same ratings, then they should be ordered by their release dates and then by titles.

SELECT title, releasedate, rating
FROM review
         JOIN users u ON review.userid = u.userid
         JOIN movies m ON review.movid = m.movid
WHERE email = 'talkiesdude@movieinfo.com'
ORDER BY rating DESC, releasedate, title;

-- Solution 2:
-- SELECT title, releasedate, rating
-- FROM review,
--      users,
--      movies
-- WHERE review.movid = movies.movid
--   AND review.userid = users.userid
--   AND email = 'talkiesdude@movieinfo.com'
-- ORDER BY rating DESC, releasedate, title;