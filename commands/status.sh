#!/usr/bin/env bash
# status.sh — vault snapshot. Run from vault root.
set -e

[[ ! -f "llm/SCHEMA.md" ]] && echo "Run from vault root" && exit 1

DATE=$(date +%Y-%m-%d)
MONTH=$(date +%Y-%m)

echo ""
echo "── Vault Status ($DATE) ──────────────────────────────"
echo ""
echo "  wiki pages:    $(find wiki/ -name '*.md' ! -name 'README*' ! -name 'index*' ! -name 'decisions*' 2>/dev/null | wc -l | tr -d ' ')"
echo "  sources:       $(find wiki/sources/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
echo "  entities:      $(find wiki/entities/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
echo "  concepts:      $(find wiki/concepts/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
echo "  logic:         $(find wiki/logic/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
echo "  hubs:          $(find wiki/hubs/ -name '*.md' ! -name 'README*' 2>/dev/null | wc -l | tr -d ' ')"
echo "  analyses:      $(find wiki/analyses/ -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
echo "  raw files:     $(find raw/ -type f ! -name '.gitkeep' ! -name '.DS_Store' 2>/dev/null | wc -l | tr -d ' ')"
echo ""
DECISIONS=$(awk -F'|' '/^\|/ && $2 !~ /^[[:space:]]*(Date|---)[[:space:]]*$/ {count++} END {print count+0}' wiki/decisions.md 2>/dev/null)
echo "  decisions:     $DECISIONS"
echo ""
echo "  last 5 ops:"
LOG="log/${MONTH}.md"
if [[ -f "$LOG" ]]; then
  grep "^\[" "$LOG" | tail -5 | sed 's/^/    /'
else
  echo "    (no log for $MONTH yet)"
fi
echo ""

if command -v git &>/dev/null && git rev-parse --git-dir &>/dev/null 2>&1; then
  DIRTY=$(git status --porcelain | wc -l | tr -d ' ')
  LAST=$(git log -1 --format="%ar — %s" 2>/dev/null)
  echo "  git: $DIRTY uncommitted | last: $LAST"
  echo ""
fi

echo "──────────────────────────────────────────────────────"
