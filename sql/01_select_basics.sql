-- ============================================================
-- 01 · Meet the database & first SELECT
-- select_basics
-- ============================================================

-- every column, first 5 rows of the samples table
SELECT * FROM samples LIMIT 5;

SELECT sample_id, environment, treatment, ph
FROM samples
LIMIT 8;

SELECT DISTINCT environment FROM samples;

SELECT DISTINCT phylum FROM taxa;

SELECT genus AS bacterium, phylum AS lineage
FROM taxa
LIMIT 10;

SELECT COUNT(*) AS n_samples FROM samples;
