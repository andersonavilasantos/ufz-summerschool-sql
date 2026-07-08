-- ============================================================
-- 04 · Aggregation (GROUP BY)
-- aggregation_groupby
-- ============================================================

SELECT COUNT(*) AS n_samples,
       COUNT(DISTINCT environment) AS n_environments
FROM samples;

-- the pH range and mean across the whole study (NULLs ignored)
SELECT MIN(ph) AS lowest_ph, MAX(ph) AS highest_ph,
       ROUND(AVG(ph), 2) AS mean_ph
FROM samples;

SELECT environment, COUNT(*) AS n_samples
FROM samples
GROUP BY environment;

-- samples per environment x treatment (a 2-way breakdown)
SELECT environment, treatment, COUNT(*) AS n_samples
FROM samples
GROUP BY environment, treatment
ORDER BY environment, treatment;

SELECT sample_id, SUM(count) AS total_reads
FROM abundance
GROUP BY sample_id
ORDER BY total_reads DESC
LIMIT 10;

SELECT environment, ROUND(AVG(ph), 2) AS mean_ph
FROM samples
GROUP BY environment;

-- min, mean and max temperature per environment in one table
SELECT environment,
       ROUND(MIN(temperature_c), 1) AS coldest,
       ROUND(AVG(temperature_c), 1) AS mean_temp,
       ROUND(MAX(temperature_c), 1) AS warmest
FROM samples
GROUP BY environment;

SELECT sample_id, SUM(count) AS total_reads
FROM abundance
GROUP BY sample_id
HAVING total_reads > 1000
ORDER BY total_reads DESC;

-- phyla represented by at least 4 taxa (filter groups by COUNT)
SELECT phylum, COUNT(*) AS n_taxa
FROM taxa
GROUP BY phylum
HAVING n_taxa >= 4
ORDER BY n_taxa DESC;

-- write your query here

-- write your query here

-- write your query here
