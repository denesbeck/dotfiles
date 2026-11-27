#!/bin/sh
# claude-resume.sh save: resurrect post-save hook, maps each pane to the Claude
#   session it runs (from @claude_session_id, set by claude-status.sh).
# claude-resume.sh run: resurrect restore command, resumes this pane's session.

dir=$(tmux show -gqv @resurrect-dir | sed "s|^~|$HOME|")
[ -n "$dir" ] || dir=${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect
map="$dir/claude_sessions"

case "$1" in
save)
  panes=$(tmux list-panes -a -F '#{@claude_session_id}	#{session_name}:#{window_index}.#{pane_index}' 2>/dev/null)
  # Server shutting down: keep the previous map
  [ -n "$panes" ] || exit 0
  printf '%s\n' "$panes" | awk -F '\t' '$1 != ""' > "$map.tmp" && mv "$map.tmp" "$map"
  ;;
run)
  target=$(tmux display -p -t "$TMUX_PANE" '#{session_name}:#{window_index}.#{pane_index}')
  id=$(awk -F '\t' -v t="$target" '$2 == t { print $1; exit }' "$map" 2>/dev/null)
  projects=${CLAUDE_CONFIG_DIR:-$HOME/.claude}/projects
  if [ -n "$id" ] && ls "$projects"/*/"$id".jsonl >/dev/null 2>&1; then
    exec claude --resume "$id"
  fi
  exec claude --continue
  ;;
esac
