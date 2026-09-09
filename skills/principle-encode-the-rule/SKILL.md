---
name: principle-encode-the-rule
description: Encode a repeated instruction as a check, not more prose. Used by hstack when a lesson would otherwise stay in chat.
user-invocable: false
---

# Encode the rule

The second time you write the same instruction, stop. Put it in a
lint, a test, a type, a schema, a script, or a skill the next agent
will actually load.

Comments that narrate what the next line does are not encoding. The
assertion, the type, or the command is the encoding.

If the rule is hstack-wide, it belongs in a principle or playbook,
in one place.
