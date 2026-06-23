# Wiki Vault

Personal knowledge system for a data developer.
Pattern: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f

Canonical local path: `/Users/soroush/Documents/ObsidianVault`

Git remote: `https://github.com/SoroushGhaderi/ObsidianVault`

---

## How it works

```
raw/        Drop sources here. Immutable.
wiki/       LLM writes here. You read here.
journal/    You write here (YYYY-MM.md, free-form). LLM reads.
log/        LLM appends here. Auto-created monthly.
llm/        Schema + agent configs.
```

One flat wiki, no work/personal split. Use `tags: [work]` or `tags: [personal]`.

## Start a session

```bash
# Claude Code
claude                        # reads CLAUDE.md → SCHEMA.md automatically

# Any chat UI
# Open llm/chatui-prompt.md, copy the prompt block, paste + your pages
```

All file-aware agents can use `skills/manage-wiki-vault/SKILL.md`. The skill is agent-neutral; `llm/SCHEMA.md` remains the authoritative vault contract.

## Common commands

```bash
./commands/status.sh                          # vault snapshot
./commands/ingest.sh raw/work/article.md      # print ingest prompt
./commands/search.sh "term"                   # full-text search
./commands/decide.sh "use Airflow over Prefect" "already have infra, team knows it"
./commands/lint.sh                            # health check
```

## Git

Read `llm/GIT.md`. Commit after every session.

## Plugins (Obsidian)

- **Dataview** — `TABLE updated FROM "wiki" WHERE type = "entity" SORT updated DESC`
- **Obsidian Git** — auto-commit, push shortcut
- **Calendar** — click month to open `journal/YYYY-MM.md`
