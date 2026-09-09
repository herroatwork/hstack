# Grok Build

## Spawn

Use `spawn_subagent`.

| Field | Value |
| --- | --- |
| `subagent_type` | `hstack-agent` for work that must follow hstack. `explore` for read-only search. `general-purpose` only when the child must edit and hstack-agent is unavailable. |
| `background` | `true` for fan-out. Drain with `get_command_or_subagent_output`. |
| `isolation` | `worktree` for any writer. `none` for read-only. |
| `model` | Only a slug from [models.md](models.md) that this session can actually run. Omit to inherit the parent. |

Grok children cannot spawn. If you are already a child, do the work
yourself.

## Tools

- Shell: `run_terminal_command`. Long jobs: `background: true`.
- Overnight wake: Grok `/loop` and the scheduler. Pair with the
  leave-running playbook.
- Project rules: `AGENTS.md` and `~/.grok/rules/*.md`.
- Model sheet: `~/.agents/hstack-models.md`. Optionally mirrored at
  `~/.grok/rules/hstack-models.md` so it always loads.

## Sessions

On-disk log: `$GROK_HOME/sessions/<encoded-cwd>/<session-id>/`
(`GROK_HOME` defaults to `~/.grok`). `updates.jsonl` is the
conversation. `summary.json` is the index. List with
`grok sessions list`. Search with `grok sessions search`. Stay inside
the encoded cwd for this workspace unless the user named another.

## Do not use

Cursor `Task`, Amp orb APIs, or nested `spawn_subagent` from a child.
