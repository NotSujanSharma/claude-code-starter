#!/usr/bin/env bash
# SessionStart hook. Silent once the project is configured.
cd "$(dirname "$0")/.." || exit 0

grep -q '<!-- UNCONFIGURED -->' docs/STACK.md 2>/dev/null || exit 0

cat <<'MSG'
[repo state] This project has not been bootstrapped: docs/STACK.md is still the
placeholder and scripts/verify.sh has no checks. You do not know this project's
language, commands, or conventions, and you cannot verify any work you do.

Before acting on the user's first request, run the /bootstrap interview. If their
request is trivial and self-contained, say you're skipping bootstrap for it and
offer to run it after.
MSG
exit 0
