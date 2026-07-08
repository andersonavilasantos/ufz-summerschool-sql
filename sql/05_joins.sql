-- ============================================================
-- 05 · Joining tables (JOIN)
-- joins
-- ============================================================

SELECT t.phylum, SUM(a.count) AS reads
FROM abundance a
JOIN taxa t ON a.taxon_id = t.taxon_id
GROUP BY t.phylum
ORDER BY reads DESC;

-- join to taxa, then summarise by the broader 'domain' rank
SELECT t.domain, SUM(a.count) AS reads
FROM abundance a
JOIN taxa t ON a.taxon_id = t.taxon_id
GROUP BY t.domain
ORDER BY reads DESC;

SELECT s.environment, SUM(a.count) AS reads
FROM abundance a
JOIN samples s ON a.sample_id = s.sample_id
GROUP BY s.environment
ORDER BY reads DESC;

-- reads per treatment (Control vs. Amended) via the same join
SELECT s.treatment, SUM(a.count) AS reads
FROM abundance a
JOIN samples s ON a.sample_id = s.sample_id
GROUP BY s.treatment
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

-- taxa completely ABSENT from sample S001 (the unmatched left rows)
SELECT t.genus, t.phylum
FROM taxa t
LEFT JOIN abundance a ON t.taxon_id = a.taxon_id AND a.sample_id = 'S001'
WHERE a.taxon_id IS NULL
ORDER BY t.genus;

-- write your query here

-- write your query here

-- write your query here
