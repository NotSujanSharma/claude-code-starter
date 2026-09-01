# Delegation

**The default is inline.** Spawning a subagent is an option you justify, not a
reflex. Every spawn starts cold and re-derives context you already have — that is
real time and real tokens.

## Spawn when

- **Read-heavy recon** whose output compresses well (search a large surface, return
  a short map). Parallel reads are always safe.
- **An independent task with a frozen contract** — the agent needs little context
  and produces a bounded diff.
- **Review**, because fresh eyes are the entire point.
- **Mechanical bulk work** — 30 call sites, one transform, clear spec.

## Don't spawn when

- Re-deriving the context costs more than the work saves.
- Two tasks touch the same files. That is a merge conflict with extra steps.
- The question is architectural. That stays in the main thread.
- You'd have to write more prompt than the agent saves you.

## Parallel safety

| Situation | Safe? |
|---|---|
| Several agents reading | always |
| Several agents writing, same working tree | **never** — they corrupt each other |
| Several agents writing, one git worktree each | yes, if contracts are frozen |

Concurrent writers get isolated worktrees. The main thread merges them.

## Model tiers

The axis is **spec-completeness and cost of being wrong**, not "simple vs. complex."
A fully specified refactor is easy work. A README with an ambiguous audience is not.

| Tier | Use for | Why |
|---|---|---|
| `haiku` | Fully specified mechanical transforms, bulk renames, formatting, test fixtures, first drafts from an outline | Spec removes the judgment |
| `sonnet` | Recon and search, implementation against a frozen contract, test writing, docs needing judgment | Good ratio when the shape is known |
| `opus` | Architecture, debugging, ambiguity, review, security, concurrency, performance, migrations | Cost of being wrong is high |

Two rules that override the table:

1. **The reviewer is never weaker than the author.**
2. **Debugging never goes cheap.** A weak model on a hard bug burns ten retry loops
   and costs more than the strong model would have.

## The dispatch contract

When you spawn, the prompt must contain all of, and little else:

- the task file path and the contract paths it must obey
- the exact files it may touch — and that it may touch no others
- the acceptance command it must run before reporting
- forbidden actions (no schema changes, no new dependencies, no refactors outside scope)
- the return format below

## The return contract

```
FILES     paths touched
DECISIONS choices made that weren't in the spec
DEVIATED  where reality differed from the task file
OPEN      questions the main thread must answer
VERIFY    the command run + pass/fail
```

Nothing else. Prose in the return value is context you paid to save and then spent.

## Stuck protocol

Two failed attempts at the same problem, then stop. Report what was tried, what was
observed, and the two most likely hypotheses. An agent that keeps going produces
increasingly creative damage.
