# Vault Commands

Run all commands from the vault root.

## Setup

```bash
chmod +x commands/*.sh

# Initialize git
./commands/git_setup.sh [optional-remote-url]
```

## Commands

| Command | What it does |
|---|---|
| `status.sh` | Vault snapshot: page counts, last ops, git status |
| `ingest.sh raw/file.md` | Validate + print ingest prompt |
| `decide.sh "decision" "reason"` | Append row to wiki/decisions.md |
| `new_logic.sh "slug" "problem"` | Scaffold a logic/reasoning note |
| `search.sh "term" [wiki\|raw\|all]` | Full-text search, no LLM |
| `lint.sh` | Local checks + print LLM lint prompt |
| `git_setup.sh [remote]` | Init git, first commit, pre-commit hook |

## Prompts

`prompts/all_prompts.md` — all LLM prompt templates in one file.
Sections: INGEST, QUERY, JOURNAL EXTRACT, DECIDE, LINT, data-specific queries.

## Multi-LLM

`llm_configs/multi_llm.md` — which model to use for what, consistency rules,
pre-commit checklist for mixed-model sessions.
