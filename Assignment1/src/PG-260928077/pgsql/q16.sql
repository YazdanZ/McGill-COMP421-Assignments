-- This query is a simple attempt of a recommendation system. List the title and release date of movies,
-- their average ratings for Comedy movies not reviewed by cinebuff@movieinfo.com (email) such that the
-- average rating of each movie is the same or higher than the average rating given by cinebuff@movieinfo.com
-- across all Comedy movies. Name the average rating column avgrating. Order the output such that the movies
-- with a higher average rating is at the top. For movies with same average rating, order them by the release
-- date and then by the title. You can assume that there will be some Comedy movies reviewed by this user in
-- the database.

SELECT title, releasedate, avgrating
FROM (
         WITH cinebuff_comedy_reviews(movid, rating, userid, genre) AS
                  (
                      SELECT r.movid, rating, userid, 'Comedy' AS genre
                      FROM review r
                               JOIN movies m ON m.movid = r.movid
                               JOIN moviegenres mg ON mg.movid = r.movid
                      WHERE userid = (
                          SELECT userid
                          FROM users
                          WHERE email = 'cinebuff@movieinfo.com'
                      )
                        AND genre = 'Comedy'
                  )

         SELECT r.movid, AVG(rating) AS avgrating
         FROM review r
                  JOIN movies m ON m.movid = r.movid
                  JOIN moviegenres mg ON mg.movid = r.movid
         WHERE EXISTS
                   (
                       SELECT *
                       FROM cinebuff_comedy_reviews
                       WHERE r.movid <> cinebuff_comedy_reviews.movid
                         AND r.userid <> cinebuff_comedy_reviews.userid
                         AND mg.genre = cinebuff_comedy_reviews.genre
                   )
         GROUP BY r.movid
         HAVING AVG(rating) >=
                (
                    SELECT AVG(rating)
                    FROM cinebuff_comedy_reviews
                )
     ) recommended_movies
         JOIN movies m ON recommended_movies.movid = m.movid
ORDER BY avgrating DESC, releasedate, title;