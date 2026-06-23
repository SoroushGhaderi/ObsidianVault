# Git Workflow

This vault is a git repository. Every LLM session that writes to wiki/ should end with a commit.

## Setup (run once)

```bash
cd /path/to/vault
git init
git add .
git commit -m "chore: vault initialized"

# Optional: push to a private remote
git remote add origin git@github.com:you/wiki-vault.git
git push -u origin main
```

## Commit conventions

```
ingest: dbt-best-practices          ← after ingesting a source
ingest: batch 3 sources             ← batch ingest
decide: switch to airflow           ← after adding a decision
lint: work space                    ← after a lint pass
wiki: update entity/dbt             ← manual wiki edit
journal: 2026-05                    ← after writing journal entries
chore: fix frontmatter              ← housekeeping
```

## Session workflow

```
# Before starting
git pull                            # if remote exists

# During session — LLM ingests, edits, etc.

# End of session
git add wiki/ journal/ log/
git diff --stat HEAD                # review what changed
git commit -m "ingest: source-name"
git push                            # if remote exists
```

## Why this matters

- Every ingest is reversible. `git revert` undoes a bad LLM edit.
- `git log --oneline` is a readable history of your knowledge growth.
- `git diff wiki/decisions.md` shows what decisions changed.
- If two LLMs produce inconsistent output, `git diff` makes the conflict visible.

## Pre-commit hook (optional)

Runs `commands/status.sh` before every commit so you see the vault state.

```bash
# vault/.git/hooks/pre-commit
#!/bin/bash
bash commands/status.sh
```

```bash
chmod +x .git/hooks/pre-commit
```
