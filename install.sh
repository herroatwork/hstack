#!/usr/bin/env bash
# Link hstack skills into the Agent Skills locations Amp and Grok scan.
# Does not edit config.toml or AGENTS.md.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
AGENTS_SKILLS="${HSTACK_AGENTS_SKILLS:-$HOME/.agents/skills}"
GROK_HOME="${GROK_HOME:-$HOME/.grok}"
GROK_SKILLS="$GROK_HOME/skills"
GROK_AGENTS="$GROK_HOME/agents"

mkdir -p "$AGENTS_SKILLS" "$GROK_SKILLS" "$GROK_AGENTS"

link_dir() {
  local src="$1"
  local dest="$2"
  ln -sfn "$src" "$dest"
  printf 'linked %s -> %s\n' "$dest" "$src"
}

for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  link_dir "$d" "$AGENTS_SKILLS/$name"
  link_dir "$d" "$GROK_SKILLS/$name"
done

if [[ -d "$ROOT/agents" ]]; then
  for a in "$ROOT"/agents/*.md; do
    [[ -e "$a" ]] || continue
    link_dir "$a" "$GROK_AGENTS/$(basename "$a")"
  done
fi

printf '\nhstack installed for this user.\n'
printf 'Amp:  ~/.agents/skills\n'
printf 'Grok: ~/.grok/skills and ~/.grok/agents\n'
printf 'Next: open a session and run /setup-hstack\n'
