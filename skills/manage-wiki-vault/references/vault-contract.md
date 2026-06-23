# Default Vault Contract

Use this only when the target vault does not provide `llm/SCHEMA.md`.

## Layout

- `raw/`: immutable source material
- `wiki/sources/`: one synthesis per ingested source
- `wiki/entities/`: tools, people, organizations, and platforms
- `wiki/concepts/`: ideas, patterns, and principles
- `wiki/logic/`: reasoning, alternatives, and trade-offs
- `wiki/analyses/`: filed answers, comparisons, and investigations
- `wiki/hubs/`: topic-level retrieval pages
- `wiki/index.md`: one entry per durable page
- `wiki/decisions.md`: append-only decision register
- `journal/`: free-form monthly notes
- `log/`: append-only monthly operation records
- `llm/`: schema and agent-specific guidance

## Page Contract

Use exactly:

```yaml
---
type: source | entity | concept | logic | analysis
tags: [work, topic]
updated: YYYY-MM-DD
---
```

Use `work` or `personal` as the first tag. Use H2/H3 headings inside pages. Use neutral, compact, factual prose. Link the first meaningful mention of an internal concept with an Obsidian wikilink.

When claims conflict, add a visible warning to both affected pages and identify the source of each claim.

## Index and Hubs

Index entry:

```text
[[path/page-slug]] | type | tag-1, tag-2
```

Create a hub when roughly five or more pages form a stable topic cluster. Each hub entry should contain a wikilink and one-line description.

## Logs and Decisions

Operation log:

```text
[YYYY-MM-DD] operation | subject | result
```

Decision row:

```text
| YYYY-MM-DD | Decision | Reasoning | Pending |
```

Allowed lifecycle: `Pending`, `Accepted`, `Dropped`, `Revisit`.
