-- ============================================================
-- 00 · Database foundations
-- database_foundations
-- ============================================================

-- SCALAR: one value from one row (the pH of a specific sample)
SELECT sample_id, ph
FROM samples
WHERE sample_id = 'S001';

-- AGGREGATE: many rows collapsed into one summary number
-- (the mean pH across every sample; AVG ignores NULLs)
SELECT AVG(ph) AS mean_ph, MIN(ph) AS lowest, MAX(ph) AS highest
FROM samples;

-- This result set has exactly the columns we name, in the order we name them.
-- (Rename freely with AS; the stored table is untouched.)
SELECT genus AS microbe, phylum AS lineage
FROM taxa
LIMIT 3;

-- A real join: attach each sample's country by matching site -> sites.site
SELECT s.sample_id, s.site, si.country
FROM samples s
JOIN sites si ON s.site = si.site
LIMIT 5;

-- Correct way to find missing measurements: IS NULL (never = NULL)
SELECT sample_id, environment, ph
FROM samples
WHERE ph IS NULL;

-- the tables in this database
SELECT name FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

-- how big is each table?
SELECT 'sites'     AS table_name, COUNT(*) AS n_rows FROM sites
UNION ALL SELECT 'samples',   COUNT(*) FROM samples
UNION ALL SELECT 'taxa',      COUNT(*) FROM taxa
UNION ALL SELECT 'abundance', COUNT(*) FROM abundance;

-- the columns and types of one table (PRAGMA is SQLite's way to inspect a table)
PRAGMA table_info(samples);

-- your first real question: how many samples per environment?
SELECT environment, COUNT(*) AS n_samples
FROM samples
GROUP BY environment;

-- another quick question: how many distinct phyla and domains do we track?
-- (COUNT(DISTINCT ...) is an aggregate over one column)
SELECT COUNT(DISTINCT phylum) AS n_phyla,
       COUNT(DISTINCT domain) AS n_domains
FROM taxa;
