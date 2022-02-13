-- List the email of all the other users who have reviewed at least one movie that was reviewed by
-- cinebuff@movieinfo.com (email) and gave a similar review. You can consider two reviews to be similar if
-- their ratings differ only by a maximum value of 1. Order the output by email.

WITH cinebuff_reviews(movid, rating, userid) AS
         (
             SELECT movid, rating, u.userid
             FROM review
                      JOIN users u ON u.userid = review.userid
             WHERE u.email = 'cinebuff@movieinfo.com'
         )
SELECT DISTINCT email
FROM review r
         JOIN users u ON r.userid = u.userid
WHERE EXISTS
          (
              SELECT movid
              FROM cinebuff_reviews
              WHERE cinebuff_reviews.movid = r.movid
                AND ABS(cinebuff_reviews.rating - r.rating) <= 1
                AND r.userid <> cinebuff_reviews.userid
          )
ORDER BY email;