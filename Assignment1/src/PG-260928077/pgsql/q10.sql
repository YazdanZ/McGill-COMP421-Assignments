-- List the title and release date of all the movies that were released in both (and not just either) English
-- and French and also had 5 or more reviews. Order the output by release date and then by title. Whether the
-- movies had been released in other languages are irrelevant.

SELECT title, releasedate
FROM movies
WHERE movid IN (
    SELECT movid
    FROM review
    WHERE movid IN (
        SELECT movid
        FROM releaselanguages
        WHERE language = 'French'
        INTERSECT
        SELECT movid
        FROM releaselanguages
        WHERE language = 'English'
    )
    GROUP BY movid
    HAVING COUNT(*) >= 5
)
ORDER BY releasedate, title;