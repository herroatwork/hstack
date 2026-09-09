# hstack

Skill pack for [Amp](https://ampcode.com) and
[Grok Build](https://grok.x.ai). One tree, two parents.

```text
/hstack <goal, and how you will know it is done>
```

`/hstack` picks a playbook, applies the principles that change a
decision, and keeps subagent fan-out in the parent. Why that shape:
[docs/why.md](docs/why.md).

## Install

```bash
./install.sh
```

Symlinks `skills/*` into `~/.agents/skills/` and `~/.grok/skills/`,
and `agents/hstack-agent.md` into `~/.grok/agents/`. Does not edit
`config.toml` or `AGENTS.md`. Re-run after new skills appear.

Grok, as a plugin instead of (or besides) the links:

```bash
grok plugin install /Users/kevin/src/hstack --trust
```

Amp: the `~/.agents/skills` links, or add `~/src/hstack/skills` to
its skill path.

## Setup

```text
/setup-hstack
```

Writes `~/.agents/hstack-models.md` if you want per-role model
overrides. Offers a project `verify-*` skill when the current repo
has a runnable app and none exists. Optional always-on routing:

```text
Non-trivial engineering work (bug, feature, refactor, investigation):
read and follow the hstack skill before acting. Casual questions stay
ordinary chat. The user can opt out for a turn by saying so.
```

Put that in user or project `AGENTS.md`, or `~/.grok/rules/`.

## Commands

| Command | When |
| --- | --- |
| `/hstack` | Non-trivial engineering work |
| `/help` | List hstack skills |
| `/how` | Walk a subsystem, read-only |
| `/prove` | Exercise the real artifact |
| `/figure-it-out` | No narrower playbook fits |
| `/interrogate` | Adversarial review of a change |
| `/recall` | Catch up on recent work |
| `/teach` | Explain so a person understands |
| `/tdd` | Failing check before production code |
| `/bro` | Restate the last message plainly |
| `/unslop` | Cut AI tells from prose |
| `/no-comments` | Strip narrative comments |
| `/reflect` | Mine this session into skill edits |
| `/show-me-your-work` | Decision log for long runs |
| `/make-bot-ui` | Local page that wakes agent work |
| `/create-verification-skill` | Repo has an app and no `verify-*` yet |
| `/maintain-verification-skill` | That skill or its map drifted |
| `/setup-hstack` | Install check and model sheet |

Playbooks behind `/hstack`: `investigate`, `fix`, `build`,
`reshape`, `leave-running`.

`/prove` prefers `<repo>/.agents/skills/verify-<app>/`, then an
existing harness, then a one-off invocation. Create writes that
skill (launch, doctor, drive, evidence, feature map) and runs one
feature before handoff. Details: [docs/why.md](docs/why.md).

## Layout

```text
skills/hstack/                      dispatcher, playbooks, adapters
skills/principle-*/                  one rule each; slash-hidden
skills/how prove setup-hstack help
skills/<name>/                       situational; /help lists them
skills/create-verification-skill/    owns verify-* contract
skills/maintain-verification-skill/
agents/hstack-agent.md              Grok child; no nested spawn
docs/why.md                          design argument
```

Harness tool names live only in `skills/hstack/references/`.

## Status

v0.2. No arena or Graphite autopilot. `/interrogate` runs the
`reviewers` list on this parent; an empty list means the parent
reviews. Competing designs: parent spawns isolated writers and
reads them.
