---
description: Commit the finished work and clear the workspace (Playbook phase 7)
---

Land the current effort.

1. Confirm `./scripts/verify.sh` passes on the full result. If it doesn't, stop.
2. Commit per task, not in one lump. Each message says **why**, not just what.
3. Append anything a future reader would question to `docs/DECISIONS.md`, including
   the alternative that was rejected.
4. Triage `.agent/FINDINGS.md`: promote each item to a task file or delete it.
   Nothing stays parked.
5. Reset `.agent/plan.md`, clear `.agent/tasks/`. Keep contracts that are still true.

Report what landed and what was deliberately left undone.
