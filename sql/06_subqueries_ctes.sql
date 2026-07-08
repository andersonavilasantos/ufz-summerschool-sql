-- ============================================================
-- 06 · Subqueries & CTEs
-- subqueries_ctes
-- ============================================================

SELECT sample_id, ph
FROM samples
WHERE ph > (SELECT AVG(ph) FROM samples);

-- samples COLDER than average (scalar subquery on the other side of <)
SELECT sample_id, temperature_c
FROM samples
WHERE temperature_c < (SELECT AVG(temperature_c) FROM samples)
ORDER BY temperature_c;

SELECT genus, phylum FROM taxa
WHERE taxon_id IN (
    SELECT taxon_id FROM abundance GROUP BY taxon_id HAVING SUM(count) > 2000
);

-- genera whose taxa are never rare-only: here, phyla NOT containing any 'big' taxon
SELECT DISTINCT phylum FROM taxa
WHERE taxon_id NOT IN (
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

-- top 5 samples by library size, built on the same CTE idea
WITH sample_reads AS (
    SELECT sample_id, SUM(count) AS total_reads
    FROM abundance GROUP BY sample_id
)
SELECT sr.sample_id, s.environment, sr.total_reads
FROM sample_reads sr
JOIN samples s ON sr.sample_id = s.sample_id
ORDER BY sr.total_reads DESC
LIMIT 5;

SELECT sample_id, taxon_id, count,
       RANK() OVER (PARTITION BY sample_id ORDER BY count DESC) AS rank_in_sample
FROM abundance
WHERE sample_id IN ('S001', 'S002')
ORDER BY sample_id, rank_in_sample;

-- write your query here

-- write your query here

-- write your query here
