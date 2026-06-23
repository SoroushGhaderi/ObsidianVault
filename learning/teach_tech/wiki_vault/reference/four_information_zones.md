# Four Information Zones

| Zone | Owner | Purpose | Mutation rule |
|---|---|---|---|
| `raw/` | Evidence | Original articles, notes, exports, and attachments | Read-only after capture |
| `wiki/` | Synthesized knowledge | Sources, entities, concepts, reasoning, analyses, hubs, decisions | LLM-assisted and schema-controlled |
| `journal/` | Human activity stream | Free-form observations, work notes, and daily context | Human-first; extraction is optional |
| `log/` | Operational audit trail | Records what the system changed and when | Append-only |

## The central distinction

The system separates **evidence**, **interpretation**, **experience**, and **operations**.

- Evidence remains stable so a synthesis can be checked later.
- Interpretation can evolve as new sources arrive.
- Experience can remain messy without polluting the durable wiki.
- Operations remain visible so maintenance is auditable.

## Data flow

```text
raw source ──ingest──> source page
                       ├──> entity pages
                       ├──> concept pages
                       ├──> index/hub updates
                       └──> operation log

journal entry ──extract──> proposed durable wiki updates
```

## Rule of thumb

Ask:

1. Is this original evidence? Put it in `raw/`.
2. Is this a durable reusable claim? Put it in `wiki/`.
3. Is this what happened or what I am thinking today? Put it in `journal/`.
4. Is this a record of a system operation? Put it in `log/`.
