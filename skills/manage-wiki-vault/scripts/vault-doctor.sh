#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

required=(raw wiki journal log llm wiki/index.md wiki/decisions.md llm/SCHEMA.md)
missing=0

echo "Vault: $(pwd)"
for path in "${required[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "MISSING $path"
    missing=$((missing + 1))
  fi
done

pages=$(find wiki -type f -name '*.md' ! -name 'index.md' ! -name 'decisions.md' ! -name 'README.md' 2>/dev/null | wc -l | tr -d ' ')
raw_files=$(find raw -type f ! -name '.DS_Store' ! -name '.gitkeep' 2>/dev/null | wc -l | tr -d ' ')
logs=$(find log -type f -name '*.md' 2>/dev/null | wc -l | tr -d ' ')

echo "Pages: $pages"
echo "Raw files: $raw_files"
echo "Log files: $logs"

if [[ -f wiki/index.md ]]; then
  echo "Pages absent from index:"
  found=0
  while IFS= read -r file; do
    rel="${file#wiki/}"
    slug="${rel%.md}"
    base="$(basename "$slug")"
    if ! grep -Fq "[[$slug" wiki/index.md && ! grep -Fq "[[$base" wiki/index.md; then
      echo "  $file"
      found=1
    fi
  done < <(find wiki -type f -name '*.md' ! -name 'index.md' ! -name 'decisions.md' ! -name 'README.md' | sort)
  [[ "$found" -eq 0 ]] && echo "  none"
fi

echo "Frontmatter anomalies:"
found=0
while IFS= read -r file; do
  head_block=$(sed -n '1,12p' "$file")
  for key in type tags updated; do
    if ! grep -Eq "^${key}:" <<<"$head_block"; then
      echo "  $file missing $key"
      found=1
    fi
  done
done < <(find wiki -type f -name '*.md' ! -name 'index.md' ! -name 'decisions.md' ! -name 'README.md' | sort)
[[ "$found" -eq 0 ]] && echo "  none"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  dirty=$(git status --porcelain | wc -l | tr -d ' ')
  echo "Git changes: $dirty"
else
  echo "Git: not initialized"
fi

exit "$missing"
