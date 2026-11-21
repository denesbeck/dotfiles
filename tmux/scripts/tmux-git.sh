#!/bin/sh
# Git indicator for the tmux window cards: "<branch> ±<changes> ↑<ahead> ↓<behind>".
# Prints nothing outside a git repo (the card then leaves the git slot empty).
cd "$1" 2>/dev/null || exit 0
git --no-optional-locks status --porcelain=v2 --branch 2>/dev/null | awk '
  /^# branch.oid /  { oid = substr($3, 1, 7) }
  /^# branch.head / { head = $3 }
  /^# branch.ab /   { ahead = $3 + 0; behind = -$4 }
  !/^#/             { n++ }
  END {
    if (head == "") exit
    if (head == "(detached)") head = oid
    out = head
    if (n) out = out " ±" n
    if (ahead) out = out " ↑" ahead
    if (behind) out = out " ↓" behind
    print out
  }'
