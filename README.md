# SQL for omics — Summer School 2026

**Using SQLs for omics: basics and hands-on**
Part of the Summer School *"Trends in multi-omics data analysis for Microbial
Ecology and Biotechnology"* — UFZ, Leipzig.

**Instructor:** Anderson Santos · **Duration:** ~4 h · **Format:** hands-on,
query-driven (no slides — you write SQL from the first minute).

This is a **beginner SQL course for biologists** — no prior database or
programming experience required. You learn SQL by querying a small **relational
microbial-ecology database**: from your first `SELECT` to multi-table `JOIN`s and
a complete mini-analysis. All data are **synthetic** (no licensing issues) but
shaped like a real amplicon study, with a built-in ecological signal so your
queries reveal real patterns.

---

## 🚀 How to run the lessons

Pick whichever suits you. For absolute beginners, **Google Colab** needs nothing
installed.

### Option A — Google Colab (easiest, nothing to install)

1. Make sure you have a Google account.
2. Click an **Open in Colab** button below.
3. Run the **first cell** (Shift+Enter) — it installs the SQL tools and connects
   to the database. Then run the cells top to bottom.

| # | Lesson | ~min | Open in Colab |
|---|--------|------|:-------------:|
| 00 | Database foundations (concepts) | 20 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/00_database_foundations.ipynb) |
| 01 | Meet the database & first SELECT | 30 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/01_select_basics.ipynb) |
| 02 | Filtering rows (WHERE) | 30 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/02_filtering_where.ipynb) |
| 03 | Sorting, limiting & computed columns | 25 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/03_sort_compute.ipynb) |
| 04 | Aggregation (GROUP BY) | 40 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/04_aggregation_groupby.ipynb) |
| 05 | Joining tables (JOIN) | 45 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/05_joins.ipynb) |
| 06 | Subqueries & CTEs | 30 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/06_subqueries_ctes.ipynb) |
| 07 | Complete & complex queries | 40 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/07_advanced_analysis.ipynb) |
| 08 | Hands-on capstone | 45 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/08_capstone.ipynb) |
| 09 | *Bonus* — creating & changing data | 20 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/09_creating_changing_data.ipynb) |

### Option B — DB Browser for SQLite (a friendly visual app)

If you prefer clicking to coding: install the free **DB Browser for SQLite**
(https://sqlitebrowser.org), open **`data/omics.db`**, go to the *Execute SQL*
tab, and paste queries from the matching **`sql/…​.sql`** file (one per lesson).

### Option C — the `sqlite3` command line

```bash
sqlite3 data/omics.db < sql/01_select_basics.sql
```

Lesson **00** gives the conceptual base (relational model, keys, what SQL is);
lessons **01–06** build query skills; **07** puts them together into complete,
realistic analytical queries; **08** is the fill-in hands-on capstone. Every
lesson opens with **learning objectives**, is full of runnable, commented
queries, has **exercises with collapsible solutions**, and closes with a
**recap**. Total is ~4 h (lessons 00–08); lesson 09 is an optional bonus.

---

## 🧬 The database (`data/omics.db`)

Four linked tables describing a microbial-ecology survey (36 samples, 6 sites,
42 taxa, ~1,300 abundance records):

```
sites (site PK) ──< samples (sample_id PK) ──< abundance >── taxa (taxon_id PK)
```

| Table | One row = | Key columns |
|-------|-----------|-------------|
| `sites` | a sampling site | `site`, `country`, `latitude`, `longitude` |
| `samples` | one sample | `sample_id`, `site`, `environment`, `treatment`, `ph`, `temperature_c`, `depth_cm`, `collection_date` |
| `taxa` | one microbial taxon | `taxon_id`, `genus`, `family`, `phylum`, `domain` |
| `abundance` | reads of a taxon in a sample | `sample_id`, `taxon_id`, `count` |

Design: 3 environments (Soil / Freshwater / Sediment) × 2 treatments
(Control / Amended) across 6 sites. Each phylum has an environmental preference,
some taxa respond to the treatment, and there is a pH gradient — so `GROUP BY`
and `JOIN` recover genuine structure (e.g. Cyanobacteria dominate freshwater,
methanogenic archaea dominate sediment, Acidobacteria dominate soil). A few
`NULL`s are included so you can practise `IS NULL`.

Regenerate the database and CSV exports at any time:

```bash
cd data && python build_database.py
```

The tables are also provided as CSVs (`data/*.csv`) and the schema as
`data/schema.sql`.

---

## 🗂️ Repository structure

```
SQL 2026/
├── README.md
├── LICENSE
├── .gitignore
├── data/        omics.db + CSV exports + schema.sql + build_database.py
├── notebooks/   00 foundations, 01–08 core lessons, 09 bonus (JupySQL, Colab-ready)
└── sql/         one .sql script per lesson (for DB Browser / sqlite3 CLI)
```

---

## ✅ Requirements

- **Colab:** nothing — the first cell installs `jupysql`.
- **Local Jupyter:** `pip install jupysql` (plus `jupyterlab`). SQLite ships with
  Python.
- **DB Browser for SQLite:** the app only (no Python).

---

## 📄 License

Teaching materials: **Creative Commons Attribution 3.0 (CC BY 3.0)** — see
[LICENSE](LICENSE). The dataset is entirely **synthetic** (built by
`data/build_database.py`) and free to reuse.
