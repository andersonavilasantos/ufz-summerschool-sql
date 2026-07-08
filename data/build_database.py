"""
Build the SYNTHETIC relational microbial-ecology database used in the
"Using SQLs for omics: basics and hands-on" session of the
"Trends in multi-omics data analysis for Microbial Ecology and
Biotechnology" Summer School (UFZ, Leipzig).

The data are synthetic (no licensing issues) but shaped like a real amplicon
study, NORMALISED across four tables so that JOINs and GROUP BY are meaningful:

    sites      (one row per sampling site)
    samples    (one row per sample; links to a site)
    taxa       (one row per taxon; genus -> family -> phylum -> domain)
    abundance  (long "fact" table: how many reads of each taxon in each sample)

There is a built-in ecological signal (each phylum prefers an environment, the
"Amended" treatment enriches some taxa, and there is a pH gradient) so queries
recover real patterns. A few NULLs are injected to teach IS NULL.

Run once (creates omics.db, the CSVs and schema.sql in this folder):
    python build_database.py
"""

import os
import sqlite3
import numpy as np
import pandas as pd

HERE = os.path.dirname(os.path.abspath(__file__))
DB = os.path.join(HERE, "omics.db")
RNG = np.random.default_rng(2026)

# ---------------------------------------------------------------------------
# Schema
# ---------------------------------------------------------------------------
SCHEMA = """
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
"""

# ---------------------------------------------------------------------------
# Taxonomy backbone: phylum -> (family, [genera]) + environment preference
# ---------------------------------------------------------------------------
BACKBONE = {
    "Pseudomonadota":    ("Pseudomonadaceae",  ["Pseudomonas", "Escherichia", "Geobacter", "Nitrosomonas", "Sphingomonas"]),
    "Bacteroidota":      ("Bacteroidaceae",    ["Bacteroides", "Flavobacterium", "Chryseobacterium"]),
    "Bacillota":         ("Bacillaceae",       ["Bacillus", "Clostridium", "Lactobacillus", "Paenibacillus"]),
    "Actinomycetota":    ("Mycobacteriaceae",  ["Streptomyces", "Mycobacterium", "Arthrobacter"]),
    "Acidobacteriota":   ("Acidobacteriaceae", ["Acidobacterium", "Terriglobus"]),
    "Cyanobacteriota":   ("Synechococcaceae",  ["Synechococcus", "Microcystis"]),
    "Euryarchaeota":     ("Methanosarcinaceae",["Methanosarcina", "Methanobrevibacter"]),
    "Nitrospirota":      ("Nitrospiraceae",    ["Nitrospira"]),
}
ARCHAEA = {"Euryarchaeota"}
ENV_PREF = {  # mean log-abundance in Soil / Freshwater / Sediment
    "Pseudomonadota":  [3.2, 3.4, 3.0], "Bacteroidota":    [2.6, 3.3, 2.8],
    "Bacillota":       [3.4, 2.4, 2.9], "Actinomycetota":  [3.6, 2.2, 2.5],
    "Acidobacteriota": [3.5, 1.8, 2.2], "Cyanobacteriota": [1.4, 3.8, 1.5],
    "Euryarchaeota":   [1.7, 1.6, 3.7], "Nitrospirota":    [2.8, 2.6, 3.0],
}
ENVS = ["Soil", "Freshwater", "Sediment"]
ENV_IX = {e: i for i, e in enumerate(ENVS)}

# ---------------------------------------------------------------------------
# sites
# ---------------------------------------------------------------------------
SITES = [
    ("LEI_SOIL",  "Soil",       "Germany", 51.34, 12.36),
    ("UPP_SOIL",  "Soil",       "Sweden",  59.86, 17.64),
    ("LEI_LAKE",  "Freshwater", "Germany", 51.42, 12.20),
    ("OSL_LAKE",  "Freshwater", "Norway",  59.91, 10.75),
    ("LEI_SED",   "Sediment",   "Germany", 51.30, 12.40),
    ("CPH_SED",   "Sediment",   "Denmark", 55.68, 12.57),
]
sites_rows = [(s, c, lat, lon) for (s, env, c, lat, lon) in SITES]
site_env = {s: env for (s, env, c, lat, lon) in SITES}

# ---------------------------------------------------------------------------
# samples
# ---------------------------------------------------------------------------
samples_rows = []
sid = 0
for (site, env, *_rest) in SITES:
    for treatment in ["Control", "Amended"]:
        for rep in range(1, 4):          # 6 sites x 2 treatments x 3 reps = 36
            sid += 1
            sample_id = f"S{sid:03d}"
            if env == "Soil":
                ph, temp, depth = RNG.normal(6.2, 0.4), RNG.normal(14, 2), RNG.uniform(0, 20)
            elif env == "Freshwater":
                ph, temp, depth = RNG.normal(7.6, 0.3), RNG.normal(18, 2), RNG.uniform(0, 5)
            else:
                ph, temp, depth = RNG.normal(7.0, 0.4), RNG.normal(12, 1.5), RNG.uniform(5, 40)
            if treatment == "Amended":
                temp += 4
            date = f"2025-0{RNG.integers(4,10)}-{RNG.integers(1,28):02d}"
            samples_rows.append([sample_id, site, env, treatment,
                                 round(float(ph), 2), round(float(temp), 1),
                                 round(float(depth), 1), date])

# inject a few NULLs (failed measurements) to teach IS NULL
for j in RNG.choice(len(samples_rows), size=3, replace=False):
    samples_rows[j][4] = None        # ph unknown
for j in RNG.choice(len(samples_rows), size=2, replace=False):
    samples_rows[j][6] = None        # depth unknown

# ---------------------------------------------------------------------------
# taxa
# ---------------------------------------------------------------------------
taxa_rows = []
tax_meta = []   # (taxon_id, phylum) for the abundance model
tid = 0
for phylum, (family, genera) in BACKBONE.items():
    domain = "Archaea" if phylum in ARCHAEA else "Bacteria"
    n = 6 if len(genera) >= 4 else 5
    for _ in range(n):
        tid += 1
        taxon_id = f"T{tid:03d}"
        genus = str(RNG.choice(genera))
        taxa_rows.append([taxon_id, genus, family, phylum, domain])
        tax_meta.append((taxon_id, phylum, RNG.normal(0, 0.4),
                         float(RNG.choice([1, 1, 1, 2.5, 3, 0.4]))))

# ---------------------------------------------------------------------------
# abundance (long fact table, with sparsity)
# ---------------------------------------------------------------------------
sample_lookup = {r[0]: r for r in samples_rows}
abundance_rows = []
for taxon_id, phylum, offset, response in tax_meta:
    base = ENV_PREF[phylum]
    for r in samples_rows:
        sample_id, site, env, treatment, ph, temp, depth, date = r
        mu = base[ENV_IX[env]] + offset
        if treatment == "Amended":
            mu += np.log(response)
        if ph is not None:
            mu += -0.12 * abs(ph - 6.8)
        lam = RNG.gamma(2.0, np.exp(mu) / 2.0)
        count = int(RNG.poisson(lam))
        if count >= 3:                    # sparsity: only store observed taxa
            abundance_rows.append([sample_id, taxon_id, count])

# ---------------------------------------------------------------------------
# Write the database
# ---------------------------------------------------------------------------
if os.path.exists(DB):
    os.remove(DB)
con = sqlite3.connect(DB)
con.executescript(SCHEMA)
con.executemany("INSERT INTO sites VALUES (?,?,?,?)", sites_rows)
con.executemany("INSERT INTO samples VALUES (?,?,?,?,?,?,?,?)", samples_rows)
con.executemany("INSERT INTO taxa VALUES (?,?,?,?,?)", taxa_rows)
con.executemany("INSERT INTO abundance VALUES (?,?,?)", abundance_rows)
con.commit()

# ---------------------------------------------------------------------------
# Export CSVs + schema.sql (so people can rebuild or inspect outside SQLite)
# ---------------------------------------------------------------------------
for name in ["sites", "samples", "taxa", "abundance"]:
    pd.read_sql_query(f"SELECT * FROM {name}", con).to_csv(
        os.path.join(HERE, f"{name}.csv"), index=False)
with open(os.path.join(HERE, "schema.sql"), "w", encoding="utf-8") as fh:
    fh.write(SCHEMA.strip() + "\n")

print("Wrote omics.db and CSVs to:", HERE)
print(f"  sites={len(sites_rows)}  samples={len(samples_rows)}  "
      f"taxa={len(taxa_rows)}  abundance={len(abundance_rows)} rows")
con.close()
