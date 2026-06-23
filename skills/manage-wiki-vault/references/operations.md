# Operation Playbook

## Ingest

1. Read the complete raw file.
2. Derive a stable lowercase hyphenated slug.
3. Search existing wiki pages for overlapping entities, concepts, and claims.
4. Create `wiki/sources/<slug>.md` with a compact summary, key claims, and connections.
5. Update existing entity/concept pages before creating duplicates.
6. Add every new page to `wiki/index.md`.
7. Create or update a hub when a stable cluster exists.
8. Log affected page count.

Do not convert every noun into a page. Create a durable page only when the topic is reusable, referenced, decision-relevant, or likely to recur.

## Query

1. Search titles and index entries.
2. Read the relevant hub when available.
3. Read only the pages needed to answer.
4. Distinguish vault evidence from inference.
5. Cite internal evidence with wikilinks.
6. Offer an analysis page only when the answer is worth preserving.

## Journal Extraction

Separate:

- transient activity, which stays in the journal;
- durable facts or lessons, which update entities/concepts;
- design reasoning, which becomes a logic note;
- explicit choices, which enter the decision register;
- source leads, which should be placed under `raw/` only by the user or with authorization.

Show proposed updates before mutating the wiki when judgment is required.

## Lint

Auto-fix only deterministic defects:

- malformed or missing required frontmatter;
- pages missing from the index;
- clearly broken internal links;
- duplicate index rows;
- missing operation log entry for the current change.

Flag for review:

- contradictory claims;
- stale time-sensitive claims;
- orphan pages;
- near-duplicate pages;
- pages that mix entity, concept, and decision responsibilities;
- clusters needing a hub.

## Logic Note

Recommended sections:

```markdown
## Problem
## Constraints
## Options Considered
## Trade-offs
## Decision
## Open Questions
```

Link the decision register when a choice is made.
