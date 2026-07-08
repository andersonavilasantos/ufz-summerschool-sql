-- ============================================================
-- 07 · Complete & complex queries
-- advanced_analysis
-- ============================================================

SELECT a.sample_id, t.phylum,
       SUM(a.count) AS reads,
       ROUND(100.0 * SUM(a.count)
             / SUM(SUM(a.count)) OVER (PARTITION BY a.sample_id), 1) AS pct_of_sample
FROM abundance a
JOIN taxa t ON a.taxon_id = t.taxon_id
GROUP BY a.sample_id, t.phylum
ORDER BY a.sample_id, pct_of_sample DESC;

WITH ranked AS (
    SELECT a.sample_id, t.genus, a.count,
           RANK() OVER (PARTITION BY a.sample_id ORDER BY a.count DESC) AS rnk
    FROM abundance a
    JOIN taxa t ON a.taxon_id = t.taxon_id
)
SELECT sample_id, genus AS dominant_genus, count
FROM ranked
WHERE rnk = 1
ORDER BY sample_id;

WITH env_phylum AS (
    SELECT s.environment, t.phylum, SUM(a.count) AS reads
    FROM abundance a
    JOIN samples s ON a.sample_id = s.sample_id
    JOIN taxa t    ON a.taxon_id  = t.taxon_id
    GROUP BY s.environment, t.phylum
),
env_total AS (
    SELECT environment, SUM(reads) AS total FROM env_phylum GROUP BY environment
)
SELECT ep.environment, ep.phylum,
       ROUND(100.0 * ep.reads / et.total, 1) AS pct
FROM env_phylum ep
JOIN env_total et ON ep.environment = et.environment
ORDER BY ep.environment, pct DESC;

SELECT t.phylum,
       SUM(CASE WHEN s.treatment = 'Control' THEN a.count ELSE 0 END) AS control_reads,
       SUM(CASE WHEN s.treatment = 'Amended' THEN a.count ELSE 0 END) AS amended_reads,
       ROUND(1.0 * SUM(CASE WHEN s.treatment = 'Amended' THEN a.count ELSE 0 END)
             / NULLIF(SUM(CASE WHEN s.treatment = 'Control' THEN a.count ELSE 0 END), 0), 2)
             AS amended_vs_control
FROM abundance a
JOIN samples s ON a.sample_id = s.sample_id
JOIN taxa t    ON a.taxon_id  = t.taxon_id
GROUP BY t.phylum
ORDER BY amended_vs_control DESC;

SELECT t.genus,
       COUNT(DISTINCT a.sample_id) AS n_samples,
       ROUND(AVG(a.count), 1) AS mean_when_present,
       SUM(a.count) AS total_reads
FROM abundance a
JOIN taxa t ON a.taxon_id = t.taxon_id
GROUP BY t.genus
HAVING n_samples >= 20
ORDER BY total_reads DESC;
