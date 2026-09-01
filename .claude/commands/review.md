---
description: Independent review of the working diff (Playbook phase 6)
---

Review target: **${ARGUMENTS:-the uncommitted working diff}**

Spawn the `critic` agent. It must read the diff and the surrounding code itself —
never a summary written by whoever produced the change. If the change is large,
split it by module across several critics rather than skimming.

Priority order:

1. **Correctness** — wrong behaviour, unhandled cases, broken invariants, race
   conditions, missing error paths. Each finding needs a concrete failure scenario.
2. **Contract drift** — does the code match `.agent/contracts/`? Drift here breaks
   things built against it.
3. **Tests** — was any test weakened, skipped, or deleted to get green? Does the new
   test actually fail when the code is wrong?
4. **Simplification** — duplication, dead code, needless abstraction.

Report findings ranked by severity with `file:line` and the failure scenario.
Speculation is labelled as such. Findings that need fixing become task files;
do not fix them inside this command.
