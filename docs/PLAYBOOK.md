# The Playbook

How work moves through this repo. Eight phases, three human gates.

The point of the structure is not process for its own sake — it is to make the
expensive mistakes cheap. A wrong assumption costs seconds in Intake, minutes in
Design, and days after Land.

---

## Phase 0 — Intake

**Goal:** agree on the problem before anyone touches the solution.

- Restate the request in your own words, including what you believe is **out of scope**.
- Ask every question whose answer would change the design. Batch them in one pass;
  do not drip questions across ten turns.
- Sweep these categories, and say explicitly when one doesn't apply:
  users and success criteria · hard constraints (performance, compatibility, deadline) ·
  systems this must integrate with · data shape and migration · failure behaviour ·
  security and access · explicit non-goals.
- If the answer is "you decide," record the assumption in the plan rather than
  leaving it implicit.

**Output:** `.agent/plan.md` § Problem, Assumptions, Non-goals
**Gate:** human confirms the restatement. ← *cheapest gate in the whole process*

---

## Phase 1 — Recon

**Goal:** replace guesses about the codebase with `file:line` facts.

- Map what exists, which patterns the repo already uses, and what will break.
- Good place to fan out **read-only** agents — parallel reads are always safe and
  their output compresses well.
- Every claim carries a pointer. "Auth is JWT-based" is a guess; "auth is JWT,
  `src/auth/verify.ts:42`" is recon.

**Output:** `.agent/plan.md` § Landscape
**Gate:** none

---

## Phase 2 — Design

**Goal:** commit to an approach and freeze the seams.

Two sub-steps, in order:

1. **High-level design** — the approach, at least one alternative you rejected and
   why, the risks, and the blast radius (what breaks if this is wrong).
2. **Contracts** — types, function signatures, API shapes, DB schema, error shapes,
   and which module owns which file. Written to `.agent/contracts/`.

Contracts are the thing that makes parallelism work. Agents building against a
frozen contract compose. Agents inventing their own shapes do not, and reconciling
them costs more than the parallelism saved.

**Output:** `.agent/plan.md` § Approach + `.agent/contracts/*.md`
**Gate:** human approves. ← *the gate that actually matters*

---

## Phase 3 — Decompose

**Goal:** turn the design into independently verifiable units.

Each task file states: goal · files it may touch · acceptance command · dependencies ·
model tier · parallel-safe yes/no.

**Sizing rule:** one agent, one context window, verifiable on its own.
**Readiness rule:** if you cannot write the acceptance command, it is not a task yet —
it is still design.

**Output:** `.agent/tasks/NN-slug.md`
**Gate:** human skims the task list. Light.

---

## Phase 4 — Execute

Dispatch per `docs/DELEGATION.md`. Default is inline in the main thread; spawning
is an option you justify, not a habit.

Every task ends the same way: acceptance command run, task file updated with what
actually happened versus what was planned.

---

## Phase 5 — Integrate

The main thread merges and runs the **full** `./scripts/verify.sh` on the combined
result. Integration bugs live here, not inside tasks — each task passing in
isolation proves nothing about the whole.

---

## Phase 6 — Review

An agent that did not write the code reads the **diff**, not the author's summary
of it. Correctness first; simplification second.

This is where second eyes actually come from. A worker agent writing code is not a
reviewer — it is one author with less context, marking its own homework.

Findings come back as tasks with file:line, not as vibes.

---

## Phase 7 — Land

Commit per task with a message that says *why*. Log decisions in `docs/DECISIONS.md`.
Triage `.agent/FINDINGS.md` into new tasks or delete it.

---

## Off-ramps

Not everything deserves eight phases. Skip to Execute when the change is obvious,
local, and verifiable in one step. Skip Recon when you already read the code this
session. The system you abandon in a week is worse than the lighter one you keep.

## Failure budget

Three failed tasks in one plan means the plan is wrong, not the agents. Stop and
return to Phase 2. Grinding through a bad decomposition is the most expensive
thing you can do.

## Anti-patterns

- **Parallel writers in one working tree.** Corruption, not speed. Use worktrees.
- **Delegating thinking.** "Figure out how auth should work" produces architecture
  by committee of amnesiacs.
- **Narration as a return value.** A subagent handing back 6k tokens of prose has
  saved you nothing.
- **CLAUDE.md sprawl.** Every line taxes every turn. Detail belongs in docs loaded
  on demand.
- **Gates that never reject.** If no plan is ever sent back, the gate is theatre.

## Measure one thing

**Rework rate** — the share of agent-produced diffs you had to redo. If a rule in
this repo does not move that number, delete the rule.
