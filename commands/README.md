# Skills & Commands

Run all commands from the vault root.

## Setup

```bash
chmod +x commands/*.sh

# Symlink into vault root (recommended)
cd /path/to/vault
for f in /path/to/skills/commands/*.sh; do ln -s "$f" commands/$(basename $f); done

# Initialize git
./commands/git-setup.sh [optional-remote-url]
```

## Commands

| Command | What it does |
|---|---|
| `status.sh` | Vault snapshot: page counts, last ops, git status |
| `ingest.sh raw/file.md` | Validate + print ingest prompt |
| `decide.sh "decision" "reason"` | Append row to wiki/decisions.md |
| `new-logic.sh "slug" "problem"` | Scaffold a logic/reasoning note |
| `search.sh "term" [wiki\|raw\|all]` | Full-text search, no LLM |
| `lint.sh` | Local checks + print LLM lint prompt |
| `git-setup.sh [remote]` | Init git, first commit, pre-commit hook |

## Prompts

`prompts/all-prompts.md` — all LLM prompt templates in one file.
Sections: INGEST, QUERY, JOURNAL EXTRACT, DECIDE, LINT, data-specific queries.

## Multi-LLM

`llm-configs/multi-llm.md` — which model to use for what, consistency rules,
pre-commit checklist for mixed-model sessions.
