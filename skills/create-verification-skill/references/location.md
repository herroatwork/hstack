# Where a project verification skill lives

Search the current repo, first match wins:

1. `<repo>/.agents/skills/verify-*/SKILL.md`
2. `<repo>/.grok/skills/verify-*/SKILL.md`

Several matches: pick the one whose surface matches the behavior
under test, or ask which. None: there is no project verification
skill yet.

Write a **new** skill only at:

```text
<repo>/.agents/skills/verify-<slug>/
```

Amp and Grok both scan `.agents/skills/`. Do not also copy it into
`.grok/skills/` (one home). If a skill already lives under
`.grok/skills/verify-*`, maintain that copy. Do not create a second
one.

`<slug>` is a valid skill name: lowercase letters, digits, hyphens,
2–64 characters, matching the directory and the frontmatter `name`.
Prefer the app or binary name (`verify-limen`, `verify-hstack`).
