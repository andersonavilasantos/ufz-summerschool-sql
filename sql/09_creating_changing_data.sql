-- ============================================================
-- 09 · Bonus — creating & changing data
-- creating_changing_data
-- ============================================================

CREATE TABLE IF NOT EXISTS my_notes (
    id      INTEGER PRIMARY KEY,
    topic   TEXT,
    note    TEXT
);

INSERT INTO my_notes (id, topic, note) VALUES
    (1, 'joins', 'link tables on a shared key'),
    (2, 'groupby', 'one summary per group');

SELECT * FROM my_notes;

UPDATE my_notes SET note = 'the heart of relational SQL' WHERE topic = 'joins';

SELECT * FROM my_notes WHERE topic = 'joins';

DELETE FROM my_notes WHERE id = 2;

SELECT COUNT(*) AS remaining FROM my_notes;

CREATE VIEW IF NOT EXISTS reads_per_environment AS
SELECT s.environment, SUM(a.count) AS reads
FROM abundance a
JOIN samples s ON a.sample_id = s.sample_id
GROUP BY s.environment;

SELECT * FROM reads_per_environment ORDER BY reads DESC;

DROP VIEW IF EXISTS reads_per_environment;

DROP TABLE IF EXISTS my_notes;
