-- Find the genre that is most liked by cinebuff@movieinfo.com (email). In order to find this, start
-- by computing the average rating this user has given to movies of different genres. Keep in mind that a movie
-- may fall into multiple genres and therefore its rating would contribute to all of those genres. You may also
-- end up with a situation where more than one genre might have the same highest average rating. In such cases,
-- order the output by the genre. You can assume that this user has made some movie reviews.

WITH genre_rating(genre, avg) AS (
    SELECT genre, AVG(rating) AS avg
    FROM review r
             JOIN users u ON r.userid = u.userid
             JOIN moviegenres mg ON r.movid = mg.movid
    WHERE u.email = 'cinebuff@movieinfo.com'
    GROUP BY genre
)
SELECT genre
FROM genre_rating
WHERE avg = (SELECT MAX(avg) FROM genre_rating)
ORDER BY genre;