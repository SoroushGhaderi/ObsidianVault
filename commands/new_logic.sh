#!/usr/bin/env bash
# new_logic.sh — create a reasoning/design note in wiki/logic/
# Usage: ./commands/new_logic.sh "slug_name" "what problem this addresses"
# Logic notes capture thinking, trade-offs, and approach — not runnable code.
set -e

SLUG="${1:-}"
PROBLEM="${2:-}"
DATE=$(date +%Y-%m-%d)
MONTH=$(date +%Y-%m)

[[ ! -f "llm/SCHEMA.md" ]] && echo "Run from vault root" && exit 1
[[ -z "$SLUG" ]] && echo 'Usage: $0 "slug" "problem description"' && exit 1
[[ ! "$SLUG" =~ ^[a-z0-9]+(_[a-z0-9]+)*$ ]] \
  && echo "Slug must use lowercase snake_case: $SLUG" \
  && exit 1

OUTPUT="wiki/logic/${SLUG}.md"
[[ -f "$OUTPUT" ]] && echo "Already exists: $OUTPUT" && exit 0

cat > "$OUTPUT" <<NOTE
---
type: logic
tags: [work]
updated: $DATE
---

_${PROBLEM}_

## Problem

## Approach Considered

## Trade-offs

## Decision
_(link to [[decisions]] row if one was created)_

## Open Questions
NOTE

# Add to index
echo "[[logic/${SLUG}]] | logic | work" >> wiki/index.md

# Log
mkdir -p log
echo "[$DATE] new_logic | $SLUG" >> "log/${MONTH}.md"

echo "✓ Created: $OUTPUT"
echo "✓ Added to wiki/index.md"
