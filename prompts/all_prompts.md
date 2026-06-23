# Prompt Templates

Copy the relevant block to your LLM agent. Fill in `[brackets]`.

---

## INGEST

```
Read llm/SCHEMA.md. Ingest raw/[path/to/file.md].
Date: [YYYY-MM-DD]
```

**Batch:**
```
Read llm/SCHEMA.md. Batch ingest the following. No discussion between files — final summary only.
- raw/[file1.md]
- raw/[file2.md]
Date: [YYYY-MM-DD]
```

---

## QUERY

```
Read llm/SCHEMA.md. Read wiki/index.md.
Question: [your question]
Answer with [[wikilinks]], then ask if I want it filed as an analysis.
```

**Targeted (you know which pages are relevant):**
```
Read llm/SCHEMA.md. Read these pages: [[entity/X]], [[concept/Y]].
Question: [your question]
```

---

## JOURNAL EXTRACT

```
Read llm/SCHEMA.md. Read journal/[YYYY-MM.md].
Extract any items that should update wiki pages.
List what you'd change — don't make changes yet.
```

**Standup:**
```
Read llm/SCHEMA.md. Read journal/[YYYY-MM.md], entries around [date].
Generate standup: Yesterday / Today / Blockers. Max 6 bullets.
```

---

## DECIDE

```
Read llm/SCHEMA.md.
Append to wiki/decisions.md: | [date] | [decision] | [reasoning] | Pending |
```
*(Or just use `./commands/decide.sh` — faster.)*

---

## LINT

```
Read llm/SCHEMA.md. Lint wiki/.
Fix silently: missing wikilinks, index gaps.
Flag: orphans, contradictions, stale claims.
Append to log/[YYYY-MM].md.
```

---

## DATA-SPECIFIC QUERIES

```
Read llm/SCHEMA.md, wiki/index.md.
List all logic/ pages tagged [dbt | airflow | spark | etc].
Summarise the approaches, note any conflicts.
```

```
Read llm/SCHEMA.md, wiki/decisions.md.
Summarise all decisions with status Pending. Group by topic.
```
