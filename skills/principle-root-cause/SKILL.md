---
name: principle-root-cause
description: Reproduce first and fix the cause, not the symptom. Used by hstack while debugging.
user-invocable: false
---

# Root cause

Reproduce the symptom before editing. If you cannot reproduce it, you
cannot know you fixed it.

Ask why until you reach the code that made the bad state legal. Fix
that. A catch, a retry, or a nil-check that swallows the crash is not
a fix unless the invariant truly allows the empty case.

Record the repro (command, input, observed output) next to the patch
so the next failure has a starting point.
