#!/usr/bin/env bash
# search.sh — full-text search across wiki. No LLM needed.
# Usage: ./commands/search.sh "term" [wiki|raw|journal|all]
set -e

QUERY="${1:-}"
SCOPE="${2:-wiki}"

[[ -z "$QUERY" ]] && echo 'Usage: $0 "term" [wiki|raw|journal|all]' && exit 1

case "$SCOPE" in
  wiki)    DIRS="wiki/" ;;
  raw)     DIRS="raw/" ;;
  journal) DIRS="journal/" ;;
  all)     DIRS="wiki/ raw/ journal/" ;;
  *)       DIRS="wiki/" ;;
esac

echo ""
echo "── search: \"$QUERY\" in $SCOPE ──"
grep -rn --include="*.md" -i "$QUERY" $DIRS --color=always -B 1 -A 1 2>/dev/null | grep -v "Binary" | sed 's/^/  /'
echo ""
echo "Files:"
grep -rl --include="*.md" -i "$QUERY" $DIRS 2>/dev/null | sort | sed 's/^/  /'
echo ""
