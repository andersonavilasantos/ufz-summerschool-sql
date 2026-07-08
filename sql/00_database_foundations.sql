-- ============================================================
-- 00 · Database foundations
-- database_foundations
-- ============================================================

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
