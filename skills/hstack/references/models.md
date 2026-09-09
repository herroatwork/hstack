# Models

Optional override file: `~/.agents/hstack-models.md`.

`/setup-hstack` writes it. A missing file, or a missing role line,
means inherit the parent session model.

## Shape

```text
# hstack model overrides. Delete a line to inherit the parent.
code: inherit-parent
judgment: inherit-parent
reviewers:
```

- `inherit-parent` and `auto` mean: omit any child model field.
- `code` is mechanical implementation.
- `judgment` is design, prose, and synthesis.
- `reviewers` is an optional comma-separated list. `/interrogate`
  spawns one read-only child per entry. An empty list means no panel;
  the parent reviews.

## Resolution

1. If the file does not exist, inherit the parent for every role.
2. Use a role's line when present.
3. A slug this session cannot run is a dropout for that lane. Do not
   substitute.

Grok Build native slugs are whatever `grok models` lists, commonly
`grok-4.6`. Amp native slugs are whatever this Amp session lists.
v0 does not shell out to other vendors.
