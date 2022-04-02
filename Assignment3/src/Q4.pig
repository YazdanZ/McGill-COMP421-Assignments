-- Write a PigLatin script such that, for each WHO region, output the region, 
-- number of countries and the total number of vaccinated people in those
-- countries. Order the output by the region.

--load vaccination data from HDFS and define the schema
vdatacsv = LOAD '/data/vaccination-data.csv' USING PigStorage(',') AS (country:CHARARRAY, iso3:CHARARRAY, who_region:CHARARRAY, persons_fully_vaccinated:INT);
Grpd = GROUP vdatacsv BY who_region;
Aggr = FOREACH Grpd GENERATE group AS who_region, COUNT(vdatacsv.country) AS num_countries, SUM(vdatacsv.persons_fully_vaccinated) AS num_vaxxed;
Res = ORDER Aggr BY who_region;
DUMP Res;
