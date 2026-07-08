-- ============================================================
-- 03 · Sorting, limiting & computed columns
-- sort_compute
-- ============================================================

SELECT sample_id, ph FROM samples
WHERE ph IS NOT NULL
ORDER BY ph DESC;

SELECT sample_id, taxon_id, count
FROM abundance
ORDER BY count DESC
LIMIT 10;

SELECT sample_id, ph FROM samples
WHERE ph IS NOT NULL
ORDER BY ph DESC
LIMIT 5 OFFSET 5;

SELECT sample_id, temperature_c,
       ROUND(temperature_c * 9.0 / 5 + 32, 1) AS temperature_f
FROM samples
LIMIT 8;

SELECT sample_id, ph,
       CASE WHEN ph < 6.5 THEN 'acidic'
            WHEN ph > 7.5 THEN 'alkaline'
            ELSE 'neutral' END AS reaction
FROM samples
WHERE ph IS NOT NULL;
