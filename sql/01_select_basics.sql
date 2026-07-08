-- ============================================================
-- 01 · Meet the database & first SELECT
-- select_basics
-- ============================================================

-- every column, first 5 rows of the samples table
SELECT * FROM samples LIMIT 5;

SELECT sample_id, environment, treatment, ph
FROM samples
LIMIT 8;

-- a different column selection, this time from the sites table
SELECT site, country, latitude
FROM sites
LIMIT 5;

SELECT DISTINCT environment FROM samples;

SELECT DISTINCT phylum FROM taxa;

-- unique (domain, phylum) pairs: which phyla sit under each domain?
SELECT DISTINCT domain, phylum
FROM taxa
ORDER BY domain, phylum;

SELECT genus AS bacterium, phylum AS lineage
FROM taxa
LIMIT 10;

-- rename site columns; AS makes the header read the way you want
SELECT site AS location, country AS nation
FROM sites;

SELECT COUNT(*) AS n_samples FROM samples;

-- 36 rows exist, but how many actually have a pH recorded?
-- COUNT(*) counts all rows; COUNT(ph) skips NULLs, so the gap = missing pH values
SELECT COUNT(*) AS n_rows, COUNT(ph) AS n_with_ph
FROM samples;

-- write your query here

-- write your query here

-- write your query here
