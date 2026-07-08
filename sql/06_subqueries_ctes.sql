-- ============================================================
-- 06 · Subqueries & CTEs
-- subqueries_ctes
-- ============================================================

SELECT sample_id, ph
FROM samples
WHERE ph > (SELECT AVG(ph) FROM samples);

SELECT genus, phylum FROM taxa
WHERE taxon_id IN (
    SELECT taxon_id FROM abundance GROUP BY taxon_id HAVING SUM(count) > 2000
);

SELECT environment, ROUND(AVG(total_reads)) AS mean_library_size
FROM (
    SELECT s.environment, s.sample_id, SUM(a.count) AS total_reads
    FROM abundance a JOIN samples s ON a.sample_id = s.sample_id
    GROUP BY s.sample_id
) AS per_sample
GROUP BY environment;

WITH sample_reads AS (
    SELECT sample_id, SUM(count) AS total_reads
    FROM abundance GROUP BY sample_id
)
SELECT s.environment, ROUND(AVG(sr.total_reads)) AS mean_library_size
FROM sample_reads sr
JOIN samples s ON sr.sample_id = s.sample_id
GROUP BY s.environment;

SELECT sample_id, taxon_id, count,
       RANK() OVER (PARTITION BY sample_id ORDER BY count DESC) AS rank_in_sample
FROM abundance
WHERE sample_id IN ('S001', 'S002')
ORDER BY sample_id, rank_in_sample;
