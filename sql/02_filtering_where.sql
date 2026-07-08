-- ============================================================
-- 02 · Filtering rows (WHERE)
-- filtering_where
-- ============================================================

SELECT * FROM samples WHERE environment = 'Soil';

SELECT sample_id, ph FROM samples WHERE ph < 6.5;

SELECT sample_id, environment, treatment
FROM samples
WHERE environment = 'Freshwater' AND treatment = 'Amended';

SELECT genus, phylum FROM taxa
WHERE phylum IN ('Cyanobacteriota', 'Euryarchaeota');

SELECT sample_id, ph FROM samples WHERE ph BETWEEN 6.5 AND 7.5;

SELECT genus, phylum FROM taxa WHERE genus LIKE 'B%';

SELECT sample_id, environment, ph FROM samples WHERE ph IS NULL;
