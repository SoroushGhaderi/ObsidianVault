#!/usr/bin/env bash
# git-setup.sh — initialize git for the vault (run once).
# Usage: ./commands/git-setup.sh [remote-url]
set -e

REMOTE="${1:-}"
[[ ! -f "llm/SCHEMA.md" ]] && echo "Run from vault root" && exit 1

if git rev-parse --git-dir &>/dev/null 2>&1; then
  echo "Git already initialized."
else
  git init
  echo "✓ git init"
fi

git add .
git commit -m "chore: vault initialized" --allow-empty
echo "✓ initial commit"

if [[ -n "$REMOTE" ]]; then
  git remote add origin "$REMOTE"
  git push -u origin main 2>/dev/null || git push -u origin master
  echo "✓ remote: $REMOTE"
fi

# Pre-commit hook: show status before every commit
HOOK=".git/hooks/pre-commit"
cat > "$HOOK" <<'HOOK_CONTENT'
#!/bin/bash
[[ -f "commands/status.sh" ]] && bash commands/status.sh
exit 0
HOOK_CONTENT
chmod +x "$HOOK"
echo "✓ pre-commit hook installed (runs status.sh)"

echo ""
echo "Commit convention:"
echo "  ingest: source-slug"
echo "  decide: short-decision"
echo "  lint: wiki"
echo "  wiki: page-edited"
echo "  journal: YYYY-MM"
echo "  chore: housekeeping"
echo ""
echo "Workflow: git add wiki/ journal/ log/ && git commit -m 'ingest: slug'"
