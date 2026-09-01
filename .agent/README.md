# .agent

Working state for the current effort. Committed on purpose — the plan is part of
the change, and reviewers should see it.

- `plan.md` — the live plan (from `/plan`)
- `tasks/NN-slug.md` — one per unit of work, updated with real outcomes
- `contracts/*.md` — interfaces frozen before any parallel work begins
- `FINDINGS.md` — out-of-scope things noticed in passing, triaged at Land

Clear `plan.md`, `tasks/`, and `FINDINGS.md` when an effort lands. Contracts that
are still true stay.
