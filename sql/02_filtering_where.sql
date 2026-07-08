-- ============================================================
-- 02 · Filtering rows (WHERE)
-- filtering_where
-- ============================================================

SELECT * FROM samples WHERE environment = 'Soil';

-- <> means 'not equal to'
SELECT sample_id, environment
FROM samples
WHERE environment <> 'Soil';

SELECT sample_id, ph FROM samples WHERE ph < 6.5;

SELECT sample_id, environment, treatment
FROM samples
WHERE environment = 'Freshwater' AND treatment = 'Amended';

-- amended samples that are EITHER acidic OR warm
SELECT sample_id, environment, ph, temperature_c
FROM samples
WHERE treatment = 'Amended'
  AND (ph < 6.5 OR temperature_c > 18);

SELECT genus, phylum FROM taxa
WHERE phylum IN ('Cyanobacteriota', 'Euryarchaeota');

-- all taxa EXCEPT the two archaeal/photosynthetic phyla above
SELECT genus, phylum
FROM taxa
WHERE phylum NOT IN ('Cyanobacteriota', 'Euryarchaeota')
LIMIT 10;

SELECT sample_id, ph FROM samples WHERE ph BETWEEN 6.5 AND 7.5;

SELECT genus, phylum FROM taxa WHERE genus LIKE 'B%';

-- families ending in 'aceae' (the standard bacterial family suffix)
SELECT DISTINCT family
FROM taxa
WHERE family LIKE '%aceae';

SELECT sample_id, environment, ph FROM samples WHERE ph IS NULL;

-- samples that HAVE a pH and are on the acidic side
SELECT sample_id, ph
FROM samples
WHERE ph IS NOT NULL AND ph < 6.5;

-- write your query here

-- write your query here

-- write your query here

-- write your query here
