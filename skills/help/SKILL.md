---
name: help
description: >
  Print a table of the current hstack skills and a short
  description of each. Use for /help, "list hstack skills",
  or "what can hstack do".
disable-model-invocation: true
---

# Help

Print the hstack catalog. Do not invent rows.

## Steps

1. Find this skill's directory (the folder that contains this
   SKILL.md). Prefer the path the harness loaded. Fall back to
   `~/.codex/skills/help` or `~/.claude/skills/help`.
2. Run `scripts/list.sh` from that directory.
3. Reply with the script's stdout. No extra catalog. Do not
   paraphrase descriptions.

The script walks the pack's `skills/*/SKILL.md`. Frontmatter
`description` is the one home. Short text is the first sentence.
`user-invocable: false` skills are listed without a slash.
