-- ============================================================
-- 05 · Joining tables (JOIN)
-- joins
-- ============================================================

SELECT t.phylum, SUM(a.count) AS reads
FROM abundance a
JOIN taxa t ON a.taxon_id = t.taxon_id
GROUP BY t.phylum
ORDER BY reads DESC;

SELECT s.environment, SUM(a.count) AS reads
FROM abundance a
JOIN samples s ON a.sample_id = s.sample_id
GROUP BY s.environment
ORDER BY reads DESC;

SELECT s.environment, t.phylum, SUM(a.count) AS reads
FROM abundance a
JOIN samples s ON a.sample_id = s.sample_id
JOIN taxa t    ON a.taxon_id  = t.taxon_id
GROUP BY s.environment, t.phylum
ORDER BY s.environment, reads DESC;

SELECT si.country, SUM(a.count) AS reads
FROM abundance a
JOIN samples s ON a.sample_id = s.sample_id
JOIN sites si  ON s.site = si.site
GROUP BY si.country
ORDER BY reads DESC;

SELECT t.genus, a.count
FROM taxa t
LEFT JOIN abundance a ON t.taxon_id = a.taxon_id AND a.sample_id = 'S001'
ORDER BY a.count DESC;
