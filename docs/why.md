# Why hstack is shaped this way

Hstack is one skill tree that Amp and Grok Build both load. Skills
are procedures. This file is the argument for the load-bearing
choices. If a rule and this memo disagree, the skill that owns the
rule wins; fix this file.

Thesis: an agent that writes code without a checkable finish
condition, and that nests work inside children that cannot nest,
produces output you cannot trust. The tree below exists to make those
two failures illegal.

## The failure that names the design

You ask:

```text
/hstack the export writes duplicate rows when a retry lands mid-run.
repro first, then fix and verify. text output stays byte-identical
when --json is off.
```

Three things have to happen: someone must understand export, someone
must change it, someone must run the real binary.

If the parent spawns a fixer, and the fixer spawns a reviewer, Grok
Build rejects the inner spawn. Depth is one: only the top-level
session may call `spawn_subagent`; a child that calls it gets a
depth-limit error (`~/.grok/docs/user-guide/16-subagents.md`). The
review becomes the child's own summary. That summary is untrusted.

If nobody encodes how to start and drive export, `/prove` invents a
path (`cargo test`, a helper the user does not run). The next session
does not have that path. The `--json` flag is "done" in chat and
wrong on the binary.

Those two failures are the whole design space. Parent-owned fan-out
fixes the first. A project `verify-*` skill fixes the second.

## Invariants

1. **One skill tree, two parents.** Amp and Grok must load the same
   `SKILL.md` files. Harness tool names live only in
   `skills/hstack/references/`.
2. **The parent owns every spawn.** Children never spawn. Writers do
   not share a writable path.
3. **One home per fact.** A search path, a playbook step, a model
   role, or a feature recipe exists in one file. Everyone else links.
4. **Done means the real artifact moved.** Compile-only, unread tests,
   and child self-reports are not proof.
5. **Creating a skill is not shipping it.** No commit, PR, or
   generated `verify-*` as a side effect of a fix unless the user
   asked.

Amp's spawn depth is not documented as one. Invariant 2 is still a
hstack rule there, so the same playbooks run on both parents. That
is a preference on Amp and a platform fact on Grok.

## Mechanism

### Dispatcher

`/hstack` matches a playbook and copies its steps into the todo
list. Principles are leaves; the dispatcher only indexes them. If
the work is "understand / change / prove" on the export bug, the
playbook is `fix`: reproduce on the binary, patch the cause, prove
on the binary. The parent may spawn read-only explorers for `how`.
It does not hand the whole task to a child and wait for "looks good."

### Adapters

`references/harness.md` detects Amp vs Grok once. Child prompts do
not mention the other harness. Shared rules (unique worktrees, file
pointers, named dropouts) are in that file. Grok's `spawn_subagent`
and Amp's threads are in `grok.md` / `amp.md`. Adding a third parent
means a new adapter, not a fork of every skill.

### Project `verify-*`

`/prove` is the bar, not the recipe. Export's launch command, ready
signal, and "duplicate rows" observation belong to the app repo.

`/create-verification-skill` interviews the checkout and writes:

```text
<repo>/.agents/skills/verify-<app>/SKILL.md
<repo>/.agents/skills/verify-<app>/features/
```

Grok scans `.agents/skills/` at every tier alongside `.grok/`
(user-guide `08-skills.md`). Amp scans `.agents/skills/` in the
project and `~/.agents/skills/` for the user. One write path serves
both. Create does not also copy into `.grok/skills/`; two copies
drift.

Create must run launch → doctor → one mapped feature → evidence →
cleanup before handoff. A skill whose Drive section was never
executed teaches the next agent a guess. Cleanup that deletes
evidence makes the run un-auditable; evidence has a named location
that survives teardown.

`/prove` then prefers that skill, then an existing repo harness, then
a one-off invocation. It offers create once. Generating `verify-export`
in the same turn as the `--json` patch mixes product work with
harness work and usually skips the "run it once" gate.

`/maintain-verification-skill` only edits the verify skill. Source
explorers are parent-spawned and read-only. The parent drives every
feature live. A map line that describes behavior the app no longer
does is either doc drift (fix the map) or a product bug (report it).
Outcomes are `clean`, `changed`, or `blocked`.

## Alternatives

**Vendor pstack or open-pstack.** pstack is MIT; copying is legal.
Its skill bodies name Cursor `Task`, sticky mode, cloud agents, and
`~/.cursor/rules/*.mdc`. Those strings do not resolve here. A
mechanical substitute table is a second product to sync. hstack
keeps the problem (throughput without a checkable finish condition)
and writes procedures that name Amp and Grok primitives in one
adapter layer. The cost is less playbook coverage (no arena or
Graphite autopilot in v0.2). `/interrogate` exists; it runs the
`reviewers` list on this parent, not a vendor mix.

**Let children spawn.** That matches "a fixer with its own
reviewer." On Grok it does not run. On Amp it still puts the
synthesis in a context that has not seen the user's constraints.
The parent already has the goal and the finish condition; it is the
cheaper place to read diffs.

**Prove with whatever is handy, never write `verify-*`.** Fine for a
one-off CLI flag in a repo you will not open again. The second
session pays the interview cost again, and the invented path is not
in git. Create is the encode-the-rule step for a repo that will see
more than one prove.

**Write new verify skills under `.grok/skills/` too.** Grok would
still find them. Amp would not, unless you also teach Amp that path.
The overlapping discovery directory is `.agents/skills/`. A second
write is a second home.

## Limits

There is no eval in this repo that hstack reduces defect rate or
token cost against a bare session. The claim is narrower: the
illegal states above cannot be produced while the skills are
followed.

v0.2 `/interrogate` is the panel. A `reviewers:` line that names a
slug this session cannot run is a dropout, not a silent substitute
(`references/models.md`). Arena-style bakeoffs are parent-owned
spawns with unique worktrees, not a named playbook yet.

Amp spawn depth is assumed, not cited from Amp docs. If Amp later
documents nested agents as supported, invariant 2 still stands as a
hstack rule so playbooks stay dual-harness.

## Conclusion

Load hstack as skills. Run `/hstack` for non-trivial work. Put
app-specific drive recipes in the app repo under
`.agents/skills/verify-<app>/`. Keep arguments in this file and
orders in `SKILL.md`.

What you can rely on: fan-out is flat; verify skills have one write
path; prove will not invent a generator as a side effect of a patch.

What you cannot: that this tree is complete, or that following it
is empirically better than a careful session without it. Those are
open.
