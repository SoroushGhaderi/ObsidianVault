# Journal

Free-form monthly captures. No required structure.

**File naming:** `YYYY-MM.md` (one file per month)
**Entry format:** `## YYYY-MM-DD` then write whatever you want — 1 line or 20 lines.

The LLM reads this when you ask it to extract wiki updates or generate a standup.
It does not impose structure on what you write here.

**Example entry:**
```
## 2026-05-29
Spent morning debugging Airflow DAG — timeout issue on the sensor.
Turned out the poke_interval was set too low. Fixed, but should document the pattern.
Good article on DuckDB in-process analytics — add to raw/work.
```
