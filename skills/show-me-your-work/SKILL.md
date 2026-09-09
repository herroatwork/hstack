---
name: show-me-your-work
description: >
  Keep an append-only TSV decision log for long or unattended runs.
  Use for /show-me-your-work, or when leave-running or figure-it-out
  needs a trail.
disable-model-invocation: true
argument-hint: path of the log if not the default
---

# Show me your work

A human who was not in the room should reconstruct what was decided,
why, and on what evidence, without reading the whole transcript.

This skill owns the trail format. Other skills point here.

## Format

One TSV, one row per decision or checkpoint. Cells are single-line.
Evidence is a pointer, not a paragraph.

Columns: `ts`, `phase`, `decision`, `why`, `evidence`, `result`.

- **ts.** UTC ISO8601.
- **phase.** Workstream or unit.
- **decision.** What was chosen, one line.
- **why.** Plain reason. If a principle drove it, say so in words.
- **evidence.** Commit, `file:line`, command, screenshot path.
- **result.** What held: `verified`, `reverted`, `inconclusive`,
  `open`, or a measured outcome.

Default path: `.hstack/decisions.tsv` in the worktree. Several
runs at once: `.hstack/<task-slug>.tsv`. Local by default. Commit
only when a reviewer needs the trail to trust the result.

Append with `scripts/log.sh`:

```text
scripts/log.sh <logfile> <phase> <decision> <why> <evidence> <result>
```

It stamps `ts`, writes the header on first use, strips tabs and
newlines, and quotes cells that would be spreadsheet formulas.

## Rules

- Append-only. A wrong call gets a new row. Never edit history.
- Log forks, landings, reverts, blockers, and one row per loop
  iteration. Skip the self-evident.
- Prefer evidence a committed script can reproduce.

## Before handoff

Walk the log against this session's transcript (harness adapter
session path). Cut invented rows. Fill gaps that shaped the work.
Each evidence pointer must resolve.

Then a second pair of eyes: one read-only child on a `reviewers`
slug if one is runnable and not the parent model; else the parent,
labeled `reviewed by parent`. Flag weak evidence, skipped proof,
and risky calls. End with **Attention**: reviewer identity, then
the flags. `No flags` is valid; omitting the identity is not.

**Reply:** path to the log, row count, attention flags.
