# Harness

Detect the parent once at task start. Read exactly one of
[grok.md](grok.md) or [amp.md](amp.md). Do not mention the other
harness in child prompts.

## Detect

- **Grok Build** if the tool list includes `spawn_subagent`, or
  `GROK_HOME` is set, or the session is clearly Grok CLI/TUI.
- **Amp** if the session is Amp (orbs, Amp skills, agent-to-agent
  threads) and `spawn_subagent` is absent.

If both signals appear, prefer the tool you can actually call.

## Shared contract

These rules hold on every parent:

1. The parent session owns every spawn. Children never spawn.
2. Each writer gets its own worktree or output directory. Shared
   writable paths across siblings are forbidden.
3. A child prompt is self-contained: goal, scope, how to verify, where
   to write, what to report. File pointers, not pasted dumps.
4. Review the child's diff yourself. Do not pass through its summary.
5. A missing model, failed child, or dropped worker is a named dropout.
   Do not silently substitute another model.
6. Model overrides live in `~/.agents/hstack-models.md` when present.
   See [models.md](models.md). Absent file means inherit the parent
   model.

## Overnight

Finish condition, isolated worktree, decision log, stop rule. The
leave-running playbook names them. Grok's `/loop` and scheduler, and
Amp orbs, are how the parent stays alive. They are not a substitute
for the finish condition.
