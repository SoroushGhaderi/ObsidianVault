---
name: manage-wiki-vault
description: Operate and maintain a structured personal Markdown/Obsidian knowledge vault with raw immutable sources, agent-written wiki pages, free-form journals, operation logs, decision records, hubs, and Git history. Use when an AI coding or chat agent needs to inspect, initialize, ingest into, query, search, lint, repair, or explain a vault following the raw/wiki/journal/log/llm layout; create source, entity, concept, logic, analysis, hub, or decision pages; extract durable knowledge from journals; or keep writes from Codex, Claude, Gemini, Cursor, and other agents consistent.
---

# Manage Wiki Vault

Treat the vault as a small knowledge system with explicit write boundaries and a retrieval layer.

This is an agent-neutral skill. Follow the workflow with the file, shell, search, and Git tools available in the current environment. Do not depend on Codex-only interfaces or metadata.

## Start

1. Locate the vault root by finding `llm/SCHEMA.md`, `wiki/index.md`, and `raw/`.
2. Read `llm/SCHEMA.md` fully when present. It overrides the bundled defaults.
3. Read `wiki/index.md` and the latest file under `log/`.
4. Run `scripts/vault-doctor.sh <vault-root>` when diagnosing structure or consistency.
5. Inspect Git status before writing. Preserve unrelated user changes.

If the vault lacks its own schema, read [references/vault-contract.md](references/vault-contract.md).
For operation-specific steps and templates, read [references/operations.md](references/operations.md).

## Boundaries

- Never modify files under `raw/`; treat them as immutable evidence.
- Write durable synthesized knowledge under `wiki/`.
- Preserve free-form user writing under `journal/`.
- Append an operation record under `log/YYYY-MM.md` for every mutation.
- Use the vault's frontmatter, linking, tone, and naming conventions exactly.
- Detect contradictions; do not silently choose one claim.
- Ask before destructive restructuring, bulk deletion, or overwriting ambiguous content.
- Do not commit or push unless the user requests it or the active vault instructions explicitly authorize it.

## Choose the Operation

- **Ingest:** Read raw evidence, create a source summary, update connected entity/concept pages, update the index, consider a hub, and log the change.
- **Query:** Use index → hub → pages retrieval, answer with wikilink citations, and offer to file a durable analysis.
- **Journal extraction:** Propose durable updates from journal entries before editing wiki pages.
- **Decision:** Append a row to `wiki/decisions.md`; preserve prior rows.
- **Logic note:** Capture the problem, alternatives, trade-offs, decision, and open questions.
- **Lint:** Fix mechanical index/link/schema defects; flag contradictions, stale claims, and orphans for judgment.
- **Status/search:** Prefer deterministic local inspection before using an LLM.

## Retrieval Discipline

For a small vault, scan `wiki/index.md`. Once the index is large, identify a relevant hub from titles, then read only the hub and target pages. Follow links only when they materially affect the answer.

## Multi-Agent Discipline

Treat `llm/SCHEMA.md` as the shared contract. Keep one agent responsible for a single ingest. Before accepting edits from different agents or models, compare frontmatter, wikilinks, tone, contradictions, and index coverage.

## Finish

1. Re-run the doctor or relevant deterministic checks.
2. Review the diff and summarize created, updated, and flagged pages.
3. Ensure the monthly log records the operation.
4. If requested, commit with a narrow message such as `ingest: source-slug`, `decide: topic`, `lint: wiki`, or `wiki: page-name`.
