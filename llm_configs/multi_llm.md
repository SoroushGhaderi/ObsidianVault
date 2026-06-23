# Multi-LLM Guide

How to use multiple LLMs without letting the wiki drift.

---

## The Core Problem

Different LLMs produce different prose styles, different link habits, different frontmatter.
Over 6 months of mixed-LLM writes, the wiki becomes inconsistent and hard to read.

**Solution: House Style in SCHEMA.md is the contract. Every LLM signs it.**

If an LLM can't follow the house style, its writes go through a review step before committing.

---

## Rule: One Writer Per Session

Don't switch LLMs mid-ingest. If you start a session with Gemini, finish it with Gemini.
Switching mid-session means the same source page gets partially written by two models.

---

## What to Use Each Model For

| Task | Best choice | Reason |
|---|---|---|
| Ingest (single source) | A capable instruction-following model | Must reliably follow the schema |
| Batch ingest (5+ sources) | A model with sufficient context | Must compare sources consistently |
| Lint pass | A strong reasoning model | Must detect cross-page conflicts |
| Journal extract → wiki | Any schema-compliant model | Low-risk proposal task |
| Logic note writing | A strong reasoning model | Requires nuanced trade-off analysis |
| Quick query / standup | A fast schema-compliant model | Simple retrieval and extraction |

---

## Before Committing a Multi-LLM Session

Run `git diff wiki/` and check:

1. **Frontmatter** — does every new page have exactly 3 fields? (`type`, `tags`, `updated`)
2. **Links** — are links in `[[wikilink]]` format, not markdown `[text](url)`?
3. **Filler phrases** — scan for "It's worth noting", "In conclusion", "Certainly"
4. **Tone** — does the new content read like the existing pages?
5. **Contradictions** — does anything conflict with existing claims?

If yes to #3 or #4 → edit before committing, or ask the writer model to fix it.

---

## Agent Setup Summary

| Agent | Config file | Start command |
|---|---|---|
| Claude Code | `CLAUDE.md` | `claude` in vault root |
| OpenAI Codex | `AGENTS.md` | Codex reads `AGENTS.md` automatically |
| Gemini CLI | paste `llm/chatui_prompt.md` | — |
| Cursor | `.cursorrules` | open vault in Cursor |
| Any chat UI | `llm/chatui_prompt.md` | copy-paste the block |

All read `llm/SCHEMA.md` as the source of truth.
