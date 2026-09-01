---
description: Interview the user about this project and generate docs/STACK.md + scripts/verify.sh
---

Configure this repo for the project it now lives in. ${ARGUMENTS:+Mode: $ARGUMENTS}

If `docs/STACK.md` is already configured (no `<!-- UNCONFIGURED -->` marker), treat
this as an update: show what's currently recorded, ask only what has changed, and
preserve everything still true.

---

### 1. Detect before you ask

Never ask what you can read. Inspect the repo first:

- Manifests and lockfiles — `package.json`, `pyproject.toml`, `requirements.txt`,
  `go.mod`, `Cargo.toml`, `Gemfile`, `pom.xml`, `build.gradle*`, `composer.json`,
  `mix.exs`, and their locks
- Version pins — `.nvmrc`, `.python-version`, `.tool-versions`, `rust-toolchain*`
- Existing scripts — the `scripts` block, `Makefile`, `Justfile`, `Taskfile`
- CI — `.github/workflows/`, `.gitlab-ci.yml` — this is often the most honest
  record of how the project is actually built and tested
- Config — test runner, linter, formatter, tsconfig, Dockerfile, compose files
- Shape — top-level source directories, where tests live, roughly how large it is

Then decide which branch you're on:

- **Greenfield** — no source yet. The stack is a *decision* to make with the user.
- **Existing** — source is here. The stack is a *fact* to confirm, not invent.

### 2. Interview

Ask in **one batch**, not drip-fed. Use `AskUserQuestion` for choices; plain text for
prose. Skip anything you already detected, but say what you detected so they can
correct it. Mark anything they leave to you as an assumption rather than silently
choosing.

Cover:

- **The project.** What it does, who uses it, what "v1 is done" looks like.
- **Stage.** Greenfield · early and still churning · established with real users.
  This sets how conservative agents should be about changing existing code.
- **Stack.** Language, runtime and version, framework, package manager, database.
  *If greenfield and they want a recommendation, give one with reasons and one
  rejected alternative — then get explicit approval before scaffolding anything.*
- **Commands.** Install · dev · test · run a single test · typecheck · lint · build.
  The single-test command matters more than it looks: it's how an agent iterates
  without waiting on the full suite.
- **Conventions an agent would get wrong.** Not house style in general — the
  specific things that look fine and aren't. Error handling, logging, where new
  files go, naming, what must never be imported from where.
- **Landmines.** What has already bitten someone here. Highest-value answer in the
  whole interview; ask for it directly.
- **Never touch.** Generated files, vendored code, applied migrations, anything
  where an edit causes silent damage.
- **Working style.** Solo or team, PR-based or direct-to-branch, and how strict
  commits need to be.

If they answer "you decide" to something, decide, and record it as an assumption in
`docs/DECISIONS.md`.

### 3. Write `docs/STACK.md`

Remove the `<!-- UNCONFIGURED -->` marker. Write the real file: what the project is,
language and runtime, a command table, layout, conventions, landmines, never-touch.

Pointers over prose — prose rots and nobody updates it. Omit sections that would be
empty rather than filling them with filler.

### 4. Wire `scripts/verify.sh`

Replace the block between the `>>> CHECKS >>>` and `<<< CHECKS <<<` markers with
real `run "<name>" <command>` lines, ordered cheapest-first.

Only include checks that exist. A verify referencing a script that isn't there is
worse than no verify — it fails for the wrong reason and teaches people to ignore it.

### 5. Prove it

Run `./scripts/verify.sh`. Do not finish this command on an unproven verify.

- A command that doesn't exist → drop it or fix it with the user now.
- Genuine test failures in an existing project → that's a real finding. Report it and
  leave verify configured; do not weaken checks to get green.

### 6. Record and hand off

Append a `docs/DECISIONS.md` entry covering the stack choice (greenfield) or the
assumptions you made (existing). Then report:

- what you detected versus what they told you
- the checks now in verify.sh, and the result of running them
- anything still unknown that will need answering at the first `/plan`

Suggest `/plan <their first task>`.
