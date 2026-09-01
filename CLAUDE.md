# Operating Rules

Short by design. Detail lives in `docs/` and loads only when relevant — every line
here costs context on every single turn.

## The loop

Intake → Recon → Design → Decompose → Execute → Integrate → Review → Land.

Defined in `docs/PLAYBOOK.md`. Start one with `/plan`.

**Off-ramp:** a change that is obvious, local, and verifiable in one step goes
straight to Execute. Do not ceremony a typo.

## Non-negotiables

1. **Ground before writing.** Never edit a file you have not read this session.
   Never call a library from memory — check the installed version's real signature.
2. **Verify before claiming done.** `./scripts/verify.sh` must pass. "Should work"
   is not a status. If you skipped a check, name it.
3. **Tests are a contract.** A failing test means the code is wrong until proven
   otherwise. Never weaken, skip, or delete a test to get green without saying so
   out loud and why.
4. **Two strikes, then stop.** Two failed attempts at the same problem → stop and
   report what you tried, what you observed, and your best hypotheses. Do not thrash.
5. **Scope is the spec.** Build what the task says. Found something else broken?
   Append it to `.agent/FINDINGS.md`. Do not fix it inline.
6. **Write decisions down.** Any choice a future reader would ask "why?" about goes
   in `docs/DECISIONS.md`, with the alternative you rejected.
7. **Secrets stay secret.** Never read `.env*`, never echo credentials, never commit them.

## Delegation

Delegate tasks, not thinking. Architecture stays in the main thread.

Rules, model tiers, and worktree safety: `docs/DELEGATION.md`.
Agent definitions: `.claude/agents/`.

Every subagent returns exactly this, and nothing else:

```
FILES     paths touched
DECISIONS choices made that weren't in the spec
DEVIATED  where reality differed from the task file
OPEN      questions the main thread must answer
VERIFY    the command run + pass/fail
```

## State lives on disk

| Path | Holds |
|---|---|
| `.agent/plan.md` | the current plan |
| `.agent/tasks/NN-*.md` | one file per task, updated with real outcomes |
| `.agent/contracts/*.md` | interfaces frozen before any parallel work |
| `.agent/FINDINGS.md` | out-of-scope observations, triaged later |
| `docs/DECISIONS.md` | why things are the way they are |

Update them as you go. Context windows end; files do not.

## This project

Stack, commands, and conventions: `docs/STACK.md`. Read it before your first edit.

**If `docs/STACK.md` still says UNCONFIGURED**, this repo has just been cloned into
a new project and you know nothing about it. Run `/bootstrap` before doing anything
substantial — it interviews the user and writes both `docs/STACK.md` and the checks
in `scripts/verify.sh`. Acting first means guessing at the language, the commands,
and the conventions, with no way to verify the result.
