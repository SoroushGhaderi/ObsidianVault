#!/usr/bin/env bash
# lint.sh — run local checks and print the LLM lint prompt.
# Usage: ./commands/lint.sh
set -e

[[ ! -f "llm/SCHEMA.md" ]] && echo "Run from vault root" && exit 1

DATE=$(date +%Y-%m-%d)
MONTH=$(date +%Y-%m)

echo ""
echo "── Lint ($DATE) ──────────────────────────────────────"
echo ""

# 1. Pages not in index
echo "Pages missing from wiki/index.md:"
MISSING=0
for f in wiki/sources/*.md wiki/entities/*.md wiki/concepts/*.md wiki/logic/*.md wiki/analyses/*.md; do
  [[ ! -f "$f" ]] && continue
  slug=$(basename "$f" .md)
  grep -q "$slug" wiki/index.md 2>/dev/null || { echo "  $f"; MISSING=$((MISSING+1)); }
done
[[ $MISSING -eq 0 ]] && echo "  none"

echo ""

# 2. Stubs (< 8 lines)
echo "Stub pages (< 8 lines):"
STUBS=0
while IFS= read -r f; do
  lines=$(wc -l < "$f")
  [[ $lines -lt 8 ]] && echo "  $f ($lines lines)" && STUBS=$((STUBS+1))
done < <(find wiki/ -name "*.md" ! -name "index*" ! -name "decisions*" ! -name "README*")
[[ $STUBS -eq 0 ]] && echo "  none"

echo ""

# 3. Hub suggestion
PAGE_COUNT=$(find wiki/ -name "*.md" ! -name "index*" ! -name "decisions*" ! -name "README*" | wc -l | tr -d ' ')
HUB_COUNT=$(find wiki/hubs/ -name "*.md" ! -name "README*" 2>/dev/null | wc -l | tr -d ' ')
[[ $PAGE_COUNT -gt 60 && $HUB_COUNT -eq 0 ]] && echo "⚠  $PAGE_COUNT pages, 0 hubs — scalability: ask LLM to create hubs"
[[ $PAGE_COUNT -gt 60 ]] && echo "  Hubs exist: $HUB_COUNT (index has $PAGE_COUNT pages)"

echo ""
echo "LLM lint prompt:"
echo "──────────────────────────────────────────────────────"
cat <<PROMPT
Read llm/SCHEMA.md, then lint wiki/.

Fix silently: missing wikilinks inline, pages absent from wiki/index.md.
Flag (don't auto-fix): orphan pages (no inbound links), contradictions, stale claims.

Append to log/${MONTH}.md: [${DATE}] lint | fixed: N | flagged: N
PROMPT
echo "──────────────────────────────────────────────────────"
