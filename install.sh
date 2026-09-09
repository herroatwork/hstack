#!/usr/bin/env bash
# Link hstack skills into the user locations Codex and Claude scan.
# Does not edit config.toml, AGENTS.md, or CLAUDE.md.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
CODEX_SKILLS="${CODEX_HOME:-$HOME/.codex}/skills"
CLAUDE_CONFIG_ROOT="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
CLAUDE_SKILLS="$CLAUDE_CONFIG_ROOT/skills"
CLAUDE_AGENTS="$CLAUDE_CONFIG_ROOT/agents"

mkdir -p "$CODEX_SKILLS" "$CLAUDE_SKILLS" "$CLAUDE_AGENTS"

link_dir() {
  local src="$1"
  local dest="$2"
  ln -sfn "$src" "$dest"
  printf 'linked %s -> %s\n' "$dest" "$src"
}

for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  link_dir "$d" "$CODEX_SKILLS/$name"
  link_dir "$d" "$CLAUDE_SKILLS/$name"
done

if [[ -d "$ROOT/agents" ]]; then
  for a in "$ROOT"/agents/*.md; do
    [[ -e "$a" ]] || continue
    link_dir "$a" "$CLAUDE_AGENTS/$(basename "$a")"
  done
fi

printf '\nhstack installed for this user.\n'
printf 'Codex:  %s\n' "$CODEX_SKILLS"
printf 'Claude: %s and %s\n' "$CLAUDE_SKILLS" "$CLAUDE_AGENTS"
printf 'Next: open a session and run /setup-hstack\n'
