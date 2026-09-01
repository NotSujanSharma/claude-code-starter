# Decisions

Append-only. Newest last. One entry per choice a future reader would question.

Skip the ceremony for reversible choices — this is for the ones with consequences.

```
## NNNN — <title>
Date: YYYY-MM-DD
Status: accepted | superseded by NNNN

**Context.** What forced a choice.
**Decision.** What we do.
**Rejected.** The alternative and why not.
**Consequence.** What this costs us later.
```

---

## 0001 — Agent state lives in files, not conversation
Date: 2026-09-01
Status: accepted

**Context.** Plans held only in a conversation die at compaction, and subagents
start cold with no access to them.

**Decision.** Plans, tasks, and contracts are files under `.agent/`. Agents read
them instead of being told.

**Rejected.** Keeping plans in the thread — cheaper per turn, but it loses state at
exactly the moment the work gets long enough to need it.

**Consequence.** Files must be updated as work happens, or they lie. A stale plan
is worse than none.
