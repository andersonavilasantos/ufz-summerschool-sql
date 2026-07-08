-- ============================================================
-- 03 · Sorting, limiting & computed columns
-- sort_compute
-- ============================================================

SELECT sample_id, ph FROM samples
WHERE ph IS NOT NULL
ORDER BY ph DESC;

-- sort by environment (A->Z), then coldest-first within each environment
SELECT sample_id, environment, temperature_c
FROM samples
WHERE temperature_c IS NOT NULL
ORDER BY environment ASC, temperature_c ASC;

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

-- combine two columns in one expression; NULLIF avoids divide-by-zero
SELECT sample_id, temperature_c, depth_cm,
       ROUND(temperature_c / NULLIF(depth_cm, 0), 2) AS temp_per_cm
FROM samples
WHERE depth_cm IS NOT NULL
LIMIT 8;

SELECT sample_id, ph,
       CASE WHEN ph < 6.5 THEN 'acidic'
            WHEN ph > 7.5 THEN 'alkaline'
            ELSE 'neutral' END AS reaction
FROM samples
WHERE ph IS NOT NULL;

-- classify each sample's thermal regime
SELECT sample_id, temperature_c,
       CASE WHEN temperature_c < 10 THEN 'cold'
            WHEN temperature_c < 20 THEN 'temperate'
            ELSE 'warm' END AS thermal_class
FROM samples
WHERE temperature_c IS NOT NULL
ORDER BY temperature_c;

-- write your query here

-- write your query here

-- write your query here
