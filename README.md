# SQL for omics — Summer School 2026

**Using SQLs for omics: basics and hands-on**
Part of the Summer School *"Trends in multi-omics data analysis for Microbial
Ecology and Biotechnology"* — UFZ, Leipzig.

**Instructor:** Anderson Santos · anderson.santos@ufz.de

---

## 👋 Welcome

This is a **beginner SQL course built for biologists** — you need **no prior
database or programming experience** at all. It is hands-on and query-driven
(**no slides**): you write SQL from the very first minute. We start from *"what is
a table?"* and build up to multi-table `JOIN`s and a complete mini-analysis of a
**relational microbial-ecology database**.

All data are **synthetic** (no licensing issues) but shaped like a real amplicon
study, with a built-in ecological signal so your queries reveal real patterns.

**By the end of the session you will be able to:**

- read the **schema** of a relational database and understand keys and links;
- retrieve and filter data with `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`;
- summarise data with **`GROUP BY`** and aggregate functions (`COUNT`, `SUM`, `AVG`);
- combine tables with **`JOIN`** — the heart of relational analysis;
- write **complete, realistic queries** (subqueries, CTEs, window functions);
- answer real biological questions with SQL in a guided capstone.

> This SQL session is the companion to the parallel **Python** and **R**
> refreshers. Each uses a **different dataset** and plays to that tool's strengths;
> SQL is where the *relational* thinking (tables linked by keys) comes to life.

---

## ✅ Prerequisites — none

You do **not** need to know SQL, any programming, or databases to follow this
session. If you can open a web browser, you can do this. Everything you need is
either already available (Google Colab) or a single free app (DB Browser for
SQLite).

Decide only *how* you want to run the lessons — see
**[How to run](#-how-to-run-the-lessons)**. If unsure, pick **Google Colab**
(nothing to install).

---

## 📅 Logistics

| | |
|---|---|
| **When** | **Wednesday, 15 July 2026, 13:30–17:30** |
| **Where** | **Building 1.0, Room 254** — UFZ, Permoserstr. 15, 04318 Leipzig |
| **Bring** | Your **laptop and its charger** |
| **Arrive** | ~**15 minutes early** to sit down, connect to Wi-Fi, and be ready to run the first cell at 13:30 |

Your name will be at the entrance — identify yourself and follow the site map to
Building 1.0. If you plan to use **DB Browser for SQLite** (Option B), install it
**before** you arrive.

---

## 🚀 How to run the lessons

Pick whichever suits you. For absolute beginners, **Google Colab** needs nothing
installed and keeps you consistent with the Python session.

### Option A — Google Colab (easiest, nothing to install)

1. Make sure you have a **Google account**.
2. Click an **Open in Colab** button below.
3. Run the **first cell** (Shift + Enter) — it installs the SQL tools and connects
   to the database. When it prints **"Connected"**, run the cells top to bottom.

> If Colab shows *"not authored by Google"*, click **Run anyway**.

| # | Lesson | ~min | Open in Colab |
|---|--------|------|:-------------:|
| 00 | Database foundations (concepts) | 25 | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/andersonavilasantos/ufz-summerschool-sql/blob/main/notebooks/00_database_foundations.ipynb) |
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
(https://sqlitebrowser.org). Then get the materials (**Code ▸ Download ZIP** on
GitHub, or `git clone`), open **`data/omics.db`** in the app, go to the
**Execute SQL** tab, and paste queries from the matching **`sql/NN_*.sql`** file
(one per lesson). Press the ▶ (F5) to run and see the result table.

### Option C — the `sqlite3` command line

```bash
sqlite3 data/omics.db < sql/01_select_basics.sql
```

### How the lessons flow

Lesson **00** gives the conceptual base (relational model, keys, what SQL is);
lessons **01–06** build query skills one clause at a time; **07** combines them
into complete, realistic analytical queries; **08** is the fill-in hands-on
capstone; **09** is an optional bonus on creating/changing data. Total ~4 h
(lessons 00–08). Every lesson opens with **learning objectives**, is full of
runnable, commented queries, has **exercises with collapsible solutions**, and
closes with a **recap**.

---

## 🧬 The database (`data/omics.db`)

Four linked tables describing a microbial-ecology survey (6 sites, 36 samples,
42 taxa, ~1,300 abundance records):

```
  sites                         taxa
  ┌───────────────┐             ┌──────────────┐
  │ site      (PK)│             │ taxon_id (PK)│
  │ country       │             │ genus/family │
  │ latitude/long │             │ phylum/domain│
  └──────┬────────┘             └──────┬───────┘
     1 │                               │ 1
       │ many                     many │
  ┌────┴───────────────┐  1  ┌─────────┴──────────────┐
  │ samples            │─────│ abundance              │
  │ sample_id     (PK) │ many│ sample_id (PK, FK)     │
  │ site          (FK) │     │ taxon_id  (PK, FK)     │
  │ environment,       │     │ count                  │
  │ treatment, ph, …   │     └────────────────────────┘
  └────────────────────┘
```

| Table | Columns (type) | Keys |
|-------|----------------|------|
| `sites` | site (TEXT), country (TEXT), latitude (REAL), longitude (REAL) | PK: site |
| `samples` | sample_id (TEXT), site (TEXT), environment (TEXT), treatment (TEXT), ph (REAL), temperature_c (REAL), depth_cm (REAL), collection_date (TEXT) | PK: sample_id · FK: site → sites |
| `taxa` | taxon_id (TEXT), genus (TEXT), family (TEXT), phylum (TEXT), domain (TEXT) | PK: taxon_id |
| `abundance` | sample_id (TEXT), taxon_id (TEXT), count (INTEGER) | PK: (sample_id, taxon_id) · FK → samples, taxa |

Design: 3 environments (Soil / Freshwater / Sediment) × 2 treatments
(Control / Amended) across 6 sites. Each phylum has an environmental preference,
some taxa respond to the treatment, and there is a pH gradient — so `GROUP BY` and
`JOIN` recover genuine structure (Cyanobacteria dominate freshwater, methanogenic
archaea dominate sediment, Acidobacteria dominate soil). A few `NULL`s let you
practise `IS NULL`.

Regenerate the database and CSV exports at any time:
`cd data && python build_database.py`. The tables are also provided as CSVs
(`data/*.csv`) and the schema as `data/schema.sql`.

---

## 🧰 Troubleshooting / FAQ

| Symptom | Fix |
|---------|-----|
| **`no such table: …`** | You skipped the **first cell** (Colab) — run it to connect. In DB Browser, make sure you opened `data/omics.db`. |
| **`no such column: …`** | A typo or wrong case — column names are case-sensitive. Check the schema above or run `PRAGMA table_info(<table>);`. |
| **`syntax error near …`** | A missing comma/keyword, or a missing `;`. Read the query slowly clause by clause (see lesson 00's *anatomy of a SELECT*). |
| Colab: *"not authored by Google"* | Normal — click **Run anyway**. |
| I changed data by mistake (lesson 09) | The core tables are safe; lesson 09 uses a throwaway table. If needed, rebuild: `python data/build_database.py`. |
| A query returns no rows | That is a valid result (an empty set) — your filter simply matched nothing. |

*Nothing to memorise — the notebooks and scripts stay with you after the course.*

---

## 🗂️ Repository structure

```
ufz-summerschool-sql/
├── README.md
├── LICENSE
├── .gitignore
├── data/        omics.db + CSV exports + schema.sql + build_database.py
├── notebooks/   00 foundations, 01–08 core lessons, 09 bonus (JupySQL, Colab-ready)
└── sql/         one .sql script per lesson (for DB Browser / sqlite3 CLI)
```

## ✅ Requirements

- **Colab:** nothing — the first cell installs `jupysql`.
- **Local Jupyter:** `pip install jupysql jupyterlab` (SQLite ships with Python).
- **DB Browser for SQLite:** just the app (no Python).

## 📄 License

Teaching materials: **Creative Commons Attribution 3.0 (CC BY 3.0)** — see
[LICENSE](LICENSE). The dataset is entirely **synthetic** (built by
`data/build_database.py`) and free to reuse.
