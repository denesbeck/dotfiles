#!/bin/sh
# Merge claude-hooks.json into ~/.claude/settings.json (idempotent).
# Replaces earlier claude-status.sh hooks, keeps every other setting and hook.
# Prints "changed" when the settings file was modified.
set -e

dir=$(cd "$(dirname "$0")" && pwd)
settings="$HOME/.claude/settings.json"

mkdir -p "$HOME/.claude"
[ -s "$settings" ] || echo '{}' > "$settings"

tmp=$(mktemp)
jq -s '
  .[1].hooks as $new
  | .[0]
  | .hooks = reduce ($new | keys[]) as $event (.hooks // {};
      .[$event] = (
        (.[$event] // [])
        | map(select(any(.hooks[]?; (.command // "") | contains("claude-status.sh")) | not))
      ) + $new[$event])
' "$settings" "$dir/claude-hooks.json" > "$tmp"

if cmp -s "$tmp" "$settings"; then
  rm -f "$tmp"
else
  mv "$tmp" "$settings"
  echo changed
fi
