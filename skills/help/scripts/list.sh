#!/usr/bin/env bash
# Print a markdown table of hstack skills from sibling SKILL.md files.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd -P)"
pack="$(cd "$here/../.." && pwd -P)"

parse() {
  awk '
    BEGIN { in_fm=0; in_desc=0; name=""; desc=""; invocable=1 }
    /^---[[:space:]]*$/ {
      if (in_fm) { emit(); exit }
      in_fm=1
      next
    }
    !in_fm { next }
    in_desc {
      if ($0 ~ /^[^[:space:]]/) { in_desc=0 }
      else {
        line=$0
        sub(/^[[:space:]]+/, "", line)
        desc=desc (desc=="" ? "" : " ") line
        next
      }
    }
    $1=="name:" {
      sub(/^name:[[:space:]]*/, "")
      gsub(/[[:space:]]+$/, "")
      gsub(/^["'\'']|["'\'']$/, "")
      name=$0
      next
    }
    $1=="user-invocable:" {
      v=$2
      gsub(/[[:space:]]/, "", v)
      if (v=="false") invocable=0
      next
    }
    $1=="description:" {
      rest=$0
      sub(/^description:[[:space:]]*/, "", rest)
      if (rest==">" || rest==">-" || rest=="|" || rest=="|-") {
        in_desc=1
        desc=""
      } else {
        gsub(/^["'\'']|["'\'']$/, "", rest)
        desc=rest
      }
      next
    }
    function emit() {
      gsub(/[[:space:]]+/, " ", desc)
      sub(/^ /, "", desc)
      sub(/ $/, "", desc)
      short=desc
      if (match(desc, /^[^.]*\./)) short=substr(desc, 1, RLENGTH)
      gsub(/\|/, "\\|", short)
      printf "%s\t%s\t%s\n", (invocable ? "1" : "0"), name, short
    }
  ' "$1"
}

rows=""
for skill_md in "$pack"/*/SKILL.md; do
  [[ -f "$skill_md" ]] || continue
  line="$(parse "$skill_md")"
  [[ -n "$line" ]] || {
    printf 'error: no frontmatter in %s\n' "$skill_md" >&2
    exit 1
  }
  rows="${rows}${line}"$'\n'
done

printf '| Skill | Description |\n'
printf '| --- | --- |\n'
printf '%s' "$rows" | LC_ALL=C sort -t$'\t' -k2,2 | while IFS=$'\t' read -r inv name short; do
  [[ -n "$name" ]] || continue
  if [[ "$inv" == "1" ]]; then
    printf '| `/%s` | %s |\n' "$name" "$short"
  else
    printf '| `%s` | %s |\n' "$name" "$short"
  fi
done
