DROP TABLE IF EXISTS abundance;
DROP TABLE IF EXISTS samples;
DROP TABLE IF EXISTS taxa;
DROP TABLE IF EXISTS sites;

CREATE TABLE sites (
    site       TEXT PRIMARY KEY,
    country    TEXT,
    latitude   REAL,
    longitude  REAL
);

CREATE TABLE samples (
    sample_id       TEXT PRIMARY KEY,
    site            TEXT REFERENCES sites(site),
    environment     TEXT,
    treatment       TEXT,
    ph              REAL,
    temperature_c   REAL,
    depth_cm        REAL,
    collection_date TEXT
);

CREATE TABLE taxa (
    taxon_id  TEXT PRIMARY KEY,
    genus     TEXT,
    family    TEXT,
    phylum    TEXT,
    domain    TEXT
);

CREATE TABLE abundance (
    sample_id TEXT REFERENCES samples(sample_id),
    taxon_id  TEXT REFERENCES taxa(taxon_id),
    count     INTEGER,
    PRIMARY KEY (sample_id, taxon_id)
);
