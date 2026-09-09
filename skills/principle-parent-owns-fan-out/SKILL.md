---
name: principle-parent-owns-fan-out
description: Only the parent session spawns workers. Used by hstack for any parallel work.
user-invocable: false
---

# Parent owns fan-out

The top-level session launches every child. A child never launches
another child. Grok Build enforces depth one; Amp threads stay
coherent the same way.

Give each writer a unique worktree or output directory. Shared
mutable paths across siblings are a bug.

The parent reads the artifacts and writes the summary. Child
self-reports are untrusted.
