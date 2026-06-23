---
name: teach-tech
description: Stateful teaching workspace for technical and software topics. Use when the user wants to learn codebase architecture, system design, Domain-Driven Design, programming concepts, engineering tradeoffs, refactoring, testing, distributed systems, data/AI engineering concepts, or other software engineering topics over multiple sessions with mission tracking, resources, reference docs, lessons, learning records, and reusable lesson assets.
---

# Teach Tech

Use this skill to teach technical/software topics over multiple sessions. When an Obsidian wiki vault is known, treat the vault as the authoritative learning workspace and follow its `llm/SCHEMA.md` before applying the generic structure below. Otherwise, treat the current directory as the teaching workspace unless the user points elsewhere.

## Workspace

Maintain this structure:

- `MISSION.md`: why the user is learning this technical topic. Use `references/MISSION-FORMAT.md`.
- `RESOURCES.md`: trusted sources and communities. Use `references/RESOURCES-FORMAT.md`.
- `reference/*.html` or `reference/*.md`: cheat sheets, glossaries, architecture notes, flowcharts, syntax references, decision guides, and compressed reusable knowledge.
- `learning-records/*.md`: numbered records of durable lessons, misconceptions corrected, architecture insights, and changes in the user's learning edge. Use `references/LEARNING-RECORD-FORMAT.md`.
- `lessons/*.html`: short self-contained lessons, numbered in order.
- `assets/*`: reusable lesson components such as stylesheets, quiz widgets, diagram helpers, code sandboxes, templates, and simulators.
- `NOTES.md`: teaching preferences, working notes, known context, and the Obsidian vault path if provided.

Create missing folders or files as needed. Before authoring a lesson, read `MISSION.md`, `RESOURCES.md`, recent `learning-records`, relevant `reference` files, and `assets`.

Name user-created files and folders in lowercase snake_case. Preserve platform-required filenames such as `README.md`, `SCHEMA.md`, `AGENTS.md`, `CLAUDE.md`, and `SKILL.md`.

## Obsidian Wiki Integration

When the Obsidian vault path is known:

1. Read `{vault}/llm/SCHEMA.md` fully at session start.
2. Store the learning mission and resources under `{vault}/learning/teach_tech/{topic}/`.
3. Store lessons, references, assets, and learning records below the same topic directory using snake_case names.
4. File durable technical knowledge into the vault's normal wiki flow:
   - source evidence remains under `raw/`;
   - reusable concepts go to `wiki/concepts/`;
   - tools, platforms, people, and organizations go to `wiki/entities/`;
   - design reasoning goes to `wiki/logic/`;
   - substantial synthesized answers go to `wiki/analyses/`;
   - explicit choices go to `wiki/decisions.md`.
5. Update `wiki/index.md`, create or update a hub when required by the vault schema, and append every mutation to the operation log.
6. Keep lesson-local pedagogy in `learning/teach_tech/`; do not duplicate every exercise into the durable wiki.
7. Use Obsidian wikilinks between lessons and durable wiki pages.

## Teaching Workflow

1. Ground the session in the mission. If `MISSION.md` is missing or vague, interview the user before creating lesson material.
2. Use `RESOURCES.md` for knowledge. Prefer official docs, source code, standards, papers, architecture decision records, high-quality books, and recognized expert material. Do not rely on parametric memory for claims that should be sourced.
3. Estimate the user's zone of proximal development from prior records and the current request.
4. Teach one tightly scoped technical move per lesson: a concept, modeling move, design tradeoff, reading strategy, debugging habit, refactoring pattern, or implementation skill.
5. Create an interactive feedback loop where possible: code reading, prediction, small design exercise, tradeoff ranking, quiz, refactoring prompt, or architecture critique.
6. Add or update reference documents when a lesson creates reusable compressed knowledge.
7. Record durable insights in `learning-records` when the user learns something non-obvious, corrects a misconception, changes mission, or gains a new technical heuristic.

## Technical Bias

Prefer concrete artifacts over abstract exposition:

- For architecture and system design, use diagrams, interface boundaries, data/control flow, failure modes, tradeoff tables, and design alternatives.
- For DDD, maintain precise ubiquitous language, bounded contexts, aggregates, domain events, invariants, context maps, and glossary terms.
- For codebase teaching, use the actual repository when available. Explain through real files, call paths, tests, and local naming conventions.
- For programming concepts, include runnable or inspectable examples when useful, but keep each lesson small enough to finish quickly.
- For AI/data engineering topics, include data contracts, evaluation loops, observability, prompt/tool boundaries, and reproducibility concerns when relevant.

## Lessons

Save each lesson to `lessons/0001_short_title.html`, incrementing the number. Lessons should be clean, readable, fast to complete, and linked to relevant references and prior lessons.

Each lesson should include:

- the goal in one sentence
- the minimum concept explanation required for the task
- a short worked example
- a retrieval or design exercise
- immediate feedback or answer key when possible
- links to the best primary source(s)
- links to related reference documents
- a reminder that the user can ask follow-up questions

Reuse `assets` by default. If a new lesson needs reusable styling, quiz logic, diagram helpers, or code widgets, create them under `assets` and link them instead of duplicating inline code.

## Reference Documents

Create reference documents for durable technical material: glossaries, code snippets, system-design checklists, DDD patterns, architecture diagrams, testing heuristics, tradeoff matrices, and failure-mode catalogs.

Reference docs should be short, scannable, printable, and easy to revisit. Once a glossary exists, reuse its terms consistently in future lessons.

## Obsidian Export Rule

Any reference docs, cheat sheets, glossaries, lesson summaries, or reusable learning materials produced by this skill must be saved to the user's Obsidian Vault when its path is known. The vault copy is authoritative; a separate workspace copy is optional.

If the Obsidian Vault path is not already known, ask the user for it before creating or exporting those materials. Once known, record it in `NOTES.md`. Preserve relative organization when possible, for example:

- `{vault}/learning/teach_tech/{mission_or_topic}/reference/`
- `{vault}/learning/teach_tech/{mission_or_topic}/lessons/`
- `{vault}/learning/teach_tech/{mission_or_topic}/learning_records/`

Prefer Markdown for Obsidian copies. If the workspace source is HTML, create a concise Markdown companion or summary in the vault and link back to the HTML lesson/reference when useful.

## Wisdom And Community

For questions that require judgment beyond controlled lessons, suggest high-quality technical communities or practitioner feedback loops: code review, architecture review, RFC discussions, standards groups, reputable forums, maintainers, or local meetups. Respect the user's preference if they do not want community recommendations.
