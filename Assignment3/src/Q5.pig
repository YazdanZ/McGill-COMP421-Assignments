-- Write a PigLatin script that will list the companies whose vaccines are
-- used across most number of countries. Output the company name and the
-- number of countries they supply to. Order the output with the companies 
-- that supply most countries on top. Restrict the output only to top 10 records.

--load vaccination metadata from HDFS and define the schema
vmetacsv = LOAD '/data/vaccination-metadata.csv' USING PigStorage(',') AS (iso3:CHARARRAY, vaccine_name:CHARARRAY, product_name:CHARARRAY, company_name:CHARARRAY);
Grpd = GROUP vmetacsv BY company_name;

Aggr = FOREACH Grpd {
	iso3 = DISTINCT vmetacsv.iso3;
	GENERATE ($0) AS company_name, COUNT(iso3) AS num_supply_countries;
};

Res = ORDER Aggr BY num_supply_countries DESC;
LimRes = LIMIT Res 10;
DUMP LimRes;
