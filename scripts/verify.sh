#!/usr/bin/env bash
# The single definition of "done". Nothing ships until this exits 0.
#
# The CHECKS block below is written by /bootstrap. You can edit it by hand too —
# just keep it between the markers so /bootstrap update can find it.
#
# Keep it FAST. A slow verify gets skipped, and a skipped verify is no verify.

set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

RAN=0
FAILED=()

run() {
  local name="$1"; shift
  RAN=$((RAN + 1))
  printf '\n\033[1m▸ %s\033[0m\n' "$name"
  if "$@"; then
    printf '\033[32m  ✓ %s\033[0m\n' "$name"
  else
    printf '\033[31m  ✗ %s\033[0m\n' "$name"
    FAILED+=("$name")
  fi
}

# >>> CHECKS >>>
# Cheapest first, so failures surface fast. Example:
#   run "typecheck" npm run typecheck
#   run "lint"      npm run lint
#   run "test"      npm test
#   run "build"     npm run build
# <<< CHECKS <<<

if [ "$RAN" -eq 0 ]; then
  printf '\033[33m
No checks are configured, so nothing here is verified.

Run /bootstrap, or add `run "<name>" <command>` lines between the CHECKS markers
in scripts/verify.sh.
\033[0m'
  exit 1
fi

if [ ${#FAILED[@]} -gt 0 ]; then
  printf '\n\033[31mFAILED: %s\033[0m\n' "${FAILED[*]}"
  exit 1
fi

[ "$RAN" -eq 1 ] && N="1 check" || N="$RAN checks"
printf '\n\033[32mAll %s passed.\033[0m\n' "$N"
