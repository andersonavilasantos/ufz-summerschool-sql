-- ============================================================
-- 04 · Aggregation (GROUP BY)
-- aggregation_groupby
-- ============================================================

SELECT COUNT(*) AS n_samples,
       COUNT(DISTINCT environment) AS n_environments
FROM samples;

SELECT environment, COUNT(*) AS n_samples
FROM samples
GROUP BY environment;

SELECT sample_id, SUM(count) AS total_reads
FROM abundance
GROUP BY sample_id
ORDER BY total_reads DESC
LIMIT 10;

SELECT environment, ROUND(AVG(ph), 2) AS mean_ph
FROM samples
GROUP BY environment;

SELECT sample_id, SUM(count) AS total_reads
FROM abundance
GROUP BY sample_id
HAVING total_reads > 1000
ORDER BY total_reads DESC;
