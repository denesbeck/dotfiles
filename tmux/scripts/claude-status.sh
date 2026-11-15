#!/bin/sh
# Called from Claude Code hooks: claude-status.sh <working|waiting|done|clear>
# Stores the state on the pane, then sets the window's @claude_status to the
# most urgent state of any pane in it (waiting > working > done).

[ -n "$TMUX_PANE" ] || exit 0
state="$1"

if [ "$state" = clear ]; then
  tmux set -pu -t "$TMUX_PANE" @claude_pane_status
else
  tmux set -p -t "$TMUX_PANE" @claude_pane_status "$state"
fi

worst=$(tmux list-panes -t "$TMUX_PANE" -F '#{@claude_pane_status}' | awk '
  $0 == "waiting" { r = 3 }
  $0 == "working" && r < 2 { r = 2 }
  $0 == "done"    && r < 1 { r = 1 }
  END { split("done working waiting", n); if (r) print n[r] }')

current=$(tmux show -wqv -t "$TMUX_PANE" @claude_status)

if [ -z "$worst" ]; then
  tmux set -wu -t "$TMUX_PANE" @claude_status \; set -wu -t "$TMUX_PANE" @claude_since
elif [ "$worst" != "$current" ]; then
  tmux set -w -t "$TMUX_PANE" @claude_status "$worst" \; set -w -t "$TMUX_PANE" @claude_since "$(date +%s)"
fi
exit 0
