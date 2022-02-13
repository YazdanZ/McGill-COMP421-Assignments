-- List the title, release date and average rating of all movies with at the least two reviews. Name the
-- average rating column avgrating. Order the output such that the movies with the highest average ratings
-- are at the top. If two movies have the same average rating, then order them further by their release dates
-- and then by titles.

SELECT title, releasedate, avgrating
FROM (
         SELECT movid, AVG(rating) AS avgrating
         FROM review
         GROUP BY movid
         HAVING COUNT(*) >= 2
     ) avg_mov_rat
         JOIN movies m ON avg_mov_rat.movid = m.movid
ORDER BY avgrating DESC, releasedate, title;