#!/usr/bin/env bash
# ingest.sh — validate a raw source and print the ingest prompt.
# Usage: ./commands/ingest.sh raw/filename.md
set -e

FILE="${1:-}"
[[ ! -f "llm/SCHEMA.md" ]] && echo "Run from vault root" && exit 1
[[ -z "$FILE" ]] && echo "Usage: $0 raw/filename.md" && exit 1
[[ ! -f "$FILE" ]] && echo "File not found: $FILE" && exit 1
[[ "$FILE" != raw/* ]] && echo "File must be under raw/" && exit 1

SLUG=$(basename "$FILE")
SLUG="${SLUG%.*}"
SLUG=$(printf '%s' "$SLUG" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/_/g; s/^_+//; s/_+$//')
[[ -z "$SLUG" ]] && echo "Could not derive a valid snake_case slug from: $FILE" && exit 1
DATE=$(date +%Y-%m-%d)

echo ""
echo "── Ingest: $FILE ──"
echo ""
cat <<PROMPT
Read llm/SCHEMA.md, then ingest this source.

File: $FILE
Date: $DATE

Steps (from SCHEMA.md INGEST):
1. Create wiki/sources/${SLUG}.md
2. Update/create entity and concept pages
3. Update wiki/index.md
4. Create a hub if 5+ pages now share a theme
5. Append to log/${DATE:0:7}.md: [${DATE}] ingest | ${SLUG} | pages: N
PROMPT
echo ""

if command -v claude &>/dev/null; then
  read -rp "Launch Claude Code? [y/N] " go
  [[ "$go" =~ ^[Yy]$ ]] && claude "Read llm/SCHEMA.md then ingest $FILE"
fi
