#!/usr/bin/env bash
# decide.sh — append a decision to wiki/decisions.md
# Usage: ./commands/decide.sh "decision text" "reasoning"
set -e

DECISION="${1:-}"
REASONING="${2:--}"
DATE=$(date +%Y-%m-%d)
MONTH=$(date +%Y-%m)
FILE="wiki/decisions.md"
LOG="log/${MONTH}.md"

[[ ! -f "llm/SCHEMA.md" ]] && echo "Run from vault root" && exit 1
[[ -z "$DECISION" ]] && echo 'Usage: $0 "decision" "reasoning"' && exit 1

echo "| $DATE | $DECISION | $REASONING | Pending |" >> "$FILE"

mkdir -p log
echo "[$DATE] decide | $DECISION" >> "$LOG"

echo "✓ Added to $FILE"
echo "  | $DATE | $DECISION | $REASONING | Pending |"
echo ""
echo "Edit $FILE to update status to: Accepted / Dropped / Revisit"
