# Wiki Schema

You maintain a personal wiki for a data developer. Read this fully before acting.

## Filename Policy

- Name user-created files and folders in lowercase `snake_case`.
- Examples: `consumer_lag.md`, `four_information_zones.md`, and `learning_records/`.
- Preserve platform-required filenames: `README.md`, `SCHEMA.md`, `AGENTS.md`, `CLAUDE.md`, and `SKILL.md`.
- Date-based filenames retain ISO punctuation, such as `2026-06-24.md`.

## Layout

```
wiki/           ← you write here (flat, one space, tags handle work/personal)
  index.md      ← one line per page: [[slug]] | type | tags
  hubs/         ← topic clusters; create when 5+ pages share a theme
  sources/      ← one summary page per ingested raw document
  entities/     ← tools, platforms, people, organisations
  concepts/     ← ideas, patterns, architectural principles
  logic/        ← reasoning notes: design thinking, approach, trade-offs
  analyses/     ← filed answers, comparisons, investigations
  decisions.md  ← append-only decision table
raw/            ← immutable source files. read; never modify
journal/        ← YYYY-MM.md free-form captures; no required structure
log/            ← YYYY-MM.md operation log; auto-created monthly
```

## Frontmatter — 3 fields only

```yaml
type: source | entity | concept | logic | analysis
tags: [work, data-engineering]   # use 'work' or 'personal' as first tag
updated: YYYY-MM-DD
```

## House Style — all LLMs must follow this exactly

- **Links:** wikilink first mention per page only: `[[Entity Name]]`
- **Tense:** present for facts ("dbt compiles SQL"), past for events ("we migrated in 2024")
- **Headers:** H2 for sections, H3 for subsections. No H1 inside pages.
- **Tone:** neutral, dense, factual. No filler phrases.
- **Forbidden phrases:** "It's worth noting", "In conclusion", "As an AI", "Certainly", "Great question"
- **Contradictions:** when a new source conflicts with an existing claim, add `> ⚠ Conflicts with [[page]]` to both pages immediately

## Operations

### INGEST `raw/filename`
1. Read the file fully.
2. Create `wiki/sources/[slug].md` — 200–400 word summary, key claims, connections.
3. Update existing entity/concept pages touched by this source. Create new ones if needed.
4. Update `wiki/index.md`.
5. If 5+ pages now share a topic and no hub exists → create `wiki/hubs/[topic].md`.
6. Append to `log/YYYY-MM.md`: `[YYYY-MM-DD] ingest | [slug] | pages: N`

### QUERY question
1. Read `wiki/index.md`. For broad topics, read the relevant hub first.
2. Read identified pages; follow links if needed.
3. Answer with `[[wikilink]]` citations.
4. Offer to file the answer as `wiki/analyses/[slug].md`.

### DECIDE "decision text"
Append one row to `wiki/decisions.md`:
`| YYYY-MM-DD | [decision] | [reasoning] | Pending |`
Status values: Pending → Accepted / Dropped / Revisit

### LINT
Find and fix: missing wikilinks inline, pages absent from `index.md`.
Flag (don't auto-fix): orphan pages, contradictions, stale claims.
Append to `log/YYYY-MM.md`: `[YYYY-MM-DD] lint | fixed: N | flagged: N`

## Scalability Protocol

`index.md` is the retrieval layer. When it exceeds ~60 entries:
- Do not read it fully for every query.
- Scan titles → identify the relevant hub → read the hub → read specific pages.
- Hub pages are O(cluster) context, not O(wiki).
- Create a hub when 5+ pages share a theme. Each hub entry: `[[page]] — one line`.
