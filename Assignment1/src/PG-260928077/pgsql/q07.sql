-- List the title, release date and language(s) of all the movies that were released in French or Italian
-- (it may also have releases in other languages but should have been released in at least one of these languages).
-- The output should be ordered by release date and then by title. If a movie is released in both French and
-- Italian then it should be listed only once in the output as a single output in the form French,Italian
-- (specifically in that alphabetical order of languages and comma separated, but no spaces between the
-- values). DO NOT output it as Italian,French Do not include other languages in the output listing (only the
-- above two). Name this ouput column languages.
-- A sample output format is shown below.
-- title | releasedate |
-- languages
-- ----------------------+-------------+----------------
-- Movie1 | 1946-01-16 | French,Italian
-- Movie3 | 1967-02-23 | Italian
-- Movie2 | 1975-05-10 | French
-- Movie4 | 2011-03-13 | French,Italian

SELECT title, releasedate, languages
FROM (
         SELECT movid, string_agg(language, ',' ORDER BY language) AS languages
         FROM releaselanguages
         WHERE language = 'French'
            OR language = 'Italian'
         GROUP BY movid
     ) AS movie_langs
         JOIN movies ON movie_langs.movid = movies.movid
ORDER BY releasedate, title;