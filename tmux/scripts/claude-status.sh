#!/bin/sh
# Called from Claude Code hooks: claude-status.sh <working|waiting|done|clear>
# Stores the state on the pane, then sets the window's @claude_status to the
# most urgent state of any pane in it (waiting > working > done).

[ -n "$TMUX_PANE" ] || exit 0
state="$1"

# Hook input on stdin carries the session id; claude-resume.sh restores it
session=$(tr -d '\n' | sed -n 's/.*"session_id" *: *"\([^"]*\)".*/\1/p')

if [ "$state" = clear ]; then
  tmux set -pu -t "$TMUX_PANE" @claude_pane_status
  tmux set -pu -t "$TMUX_PANE" @claude_session_id
else
  tmux set -p -t "$TMUX_PANE" @claude_pane_status "$state"
  if [ -n "$session" ] && [ "$session" != "$(tmux show -pqv -t "$TMUX_PANE" @claude_session_id)" ]; then
    tmux set -p -t "$TMUX_PANE" @claude_session_id "$session"
  fi
fi

worst=$(tmux list-panes -t "$TMUX_PANE" -F '#{@claude_pane_status}' | awk '
  $0 == "waiting" { r = 3 }
  $0 == "working" && r < 2 { r = 2 }
  $0 == "done"    && r < 1 { r = 1 }
  END { split("done working waiting", n); if (r) print n[r] }')

[ "$worst" = "$(tmux show -wqv -t "$TMUX_PANE" @claude_status)" ] && exit 0

if [ -z "$worst" ]; then
  tmux set -wu -t "$TMUX_PANE" @claude_status
else
  tmux set -w -t "$TMUX_PANE" @claude_status "$worst"
fi

# Redraw every client's status bar now instead of on the next status-interval.
tmux list-clients -F '#{client_name}' | while read -r c; do
  tmux refresh-client -S -t "$c"
done
exit 0
