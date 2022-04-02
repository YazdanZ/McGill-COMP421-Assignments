-- For countries with population above 100 million, list each country,
-- its population, the percentage of fully vaccinated people and the 
-- number of vaccine brands used in that country. Order the output by
-- the decreasing order of their population.


-- load vaccination data and metadata and world population data from HDFS and define schema
popcsv = LOAD '/data/pop.csv' USING PigStorage(',') AS (country:CHARARRAY, population:INT);
vdatacsv = LOAD '/data/vaccination-data.csv' USING PigStorage(',') AS (country:CHARARRAY, iso3:CHARARRAY, who_region:CHARARRAY, persons_fully_vaccinated:INT);
vmetacsv = LOAD '/data/vaccination-metadata.csv' USING PigStorage(',') AS (iso3:CHARARRAY, vaccine_name:CHARARRAY, product_name:CHARARRAY, company_name:CHARARRAY);

-- Do projections early on
vdatacsv = FOREACH vdatacsv GENERATE country, iso3, persons_fully_vaccinated;
vmetacsv = FOREACH vmetacsv GENERATE iso3, product_name;

-- Note: population is in thousands
highpop = FILTER popcsv BY  population > 100000;
Jnd = JOIN highpop BY country, vdatacsv BY country;
Proj = FOREACH Jnd GENERATE highpop::country, highpop::population, vdatacsv::persons_fully_vaccinated, vdatacsv::iso3; 

Jnd2 = JOIN Proj BY iso3, vmetacsv BY iso3;
Grpd = GROUP Jnd2 BY country;

-- What does the schema look like immediately after you perform the GROUP operation step?
-- grunt> DESCRIBE Grpd;
-- Grpd: {
--     group: chararray,
--     Jnd2: {
--         (
--             Proj::highpop::country: chararray,
--             Proj::highpop::population: int,
--             Proj::vdatacsv::persons_fully_vaccinated: int,
--             Proj::vdatacsv::iso3: chararray,
--             vmetacsv::iso3: chararray,
--             vmetacsv::product_name: chararray
--         )
--     }
-- }



Res = FOREACH Grpd {
    -- Note: population is in thousands 
    --  perc_fully_vaxxed = FOREACH Jnd2 GENERATE (persons_fully_vaccinated * 100) / (population * 1000);
    -- This is same as above:
    perc_fully_vaxxed = FOREACH Jnd2 GENERATE (persons_fully_vaccinated) / (double) (population * 10);

    perc_fully_vaxxed = DISTINCT perc_fully_vaxxed;
    population = FOREACH Jnd2 GENERATE population;
    population = DISTINCT population;
    GENERATE group AS country, FLATTEN(population), FLATTEN(perc_fully_vaxxed), COUNT(Jnd2.product_name); 
};

OrdRes = ORDER Res BY population DESC;
DUMP OrdRes;

