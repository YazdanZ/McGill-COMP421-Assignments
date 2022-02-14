-- List all the languages in the database and the genre that has most movies for that language. If two
-- genres are equally the most popular for the language, produce two rows in the output (and so forth). Order
-- the output by languages and then by genre.
-- A sample format is given below:
-- language | genre
-- ----------+-----------
-- French   | Drama
-- French   | Sci-Fi
-- German   | Drama
-- Greek    | Action
-- Greek    | Adventure

WITH genre_lang_count(language, genre, count) AS
         (
             SELECT rl.language, genre, COUNT(*)
             FROM releaselanguages rl
                      JOIN moviegenres mg ON mg.movid = rl.movid
             GROUP BY language, genre
         )
SELECT language, genre
FROM genre_lang_count as glc
WHERE count >= ALL
      (
          SELECT count
          FROM genre_lang_count as glc2
          WHERE glc.language = glc2.language
      )
ORDER BY language, genre;