# Leave running

The user is stepping away. Drive to a checkable finish condition.

## Steps

1. Write a contract in the todo list: goal, finish condition,
   permissions already granted, stop rule (stuck after N failed
   checks, or a named blocker).
2. Work in an isolated worktree or Amp orb. Do not leave half-edits
   in the user's dirty tree unless they asked to.
3. Keep a decision log via **show-me-your-work**. Default path
   `.hstack/decisions.tsv` in the worktree. That skill owns the
   columns. Commit the trail if the user wants an audit; otherwise
   leave it in the worktree.
4. Apply **reversible-without-asking** inside the contract. Still
   pause for the irreversible list in hstack SKILL.md.
5. Loop: do the next verifiable unit, **prove** it, then the next.
   Use the parent harness wake mechanism (`/loop` on Grok, orb
   continuation on Amp) only to re-check the finish condition.
6. Stop when the finish condition holds, or when the stop rule
   fires. Write what is done, what is not, and why you stopped.
