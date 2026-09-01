---
description: Execute the current task graph (Playbook phases 4–5)
---

Execute `.agent/tasks/` — or only **$ARGUMENTS** if task numbers were given.

Rules:

- Respect dependencies. Run independent tasks concurrently **only** if they are
  marked parallel-safe and each writer gets its own git worktree
  (`docs/DELEGATION.md`). Same-tree parallel writes corrupt each other.
- Default to inline. Spawn a subagent when `docs/DELEGATION.md` says it earns its
  keep, using the tier on the task file and the dispatch contract.
- Every task ends with its acceptance command actually run, and its Outcome section
  filled in with what happened versus what was planned.
- Out-of-scope breakage goes to `.agent/FINDINGS.md`, not into the diff.
- Two failed attempts at the same problem → stop and report. Do not thrash.
- Three failed tasks → the plan is wrong. Stop and return to Design.

When all tasks are done, integrate in the main thread and run the **full**
`./scripts/verify.sh` on the combined result. Report task-by-task status plus the
verify outcome. Then suggest `/review`.
