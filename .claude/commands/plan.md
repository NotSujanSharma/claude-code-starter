---
description: Run Intake → Recon → Design → Decompose for a new piece of work
---

Follow `docs/PLAYBOOK.md` phases 0–3 for: **$ARGUMENTS**

Work through them in order. Do not write implementation code in this command.

**Phase 0 — Intake.** Restate the request, including what you believe is out of
scope. Then ask, in a single batch, every question whose answer would change the
design — sweep users/success criteria, hard constraints, systems to integrate with,
data and migration, failure behaviour, security, and non-goals, saying explicitly
when one doesn't apply. Stop and wait for answers. Do not proceed on assumptions
you could simply have asked about.

**Phase 1 — Recon.** Read the code. Every claim gets a `file:line`. Fan out
read-only agents if the surface is large; keep their returns short.

**Phase 2 — Design.** Write the approach, one rejected alternative and why, the
risks, and the blast radius. Then write the contracts to `.agent/contracts/` —
types, signatures, schemas, error shapes, file ownership. **Stop here and get
approval before decomposing.**

**Phase 3 — Decompose.** One file per task in `.agent/tasks/` using
`.agent/tasks/TEMPLATE.md`. Each needs an acceptance command; if you can't write
one, the task isn't ready. Mark dependencies, parallel-safety, and model tier per
`docs/DELEGATION.md`.

Keep `.agent/plan.md` current as you go. Present the task list for a skim, then stop.
