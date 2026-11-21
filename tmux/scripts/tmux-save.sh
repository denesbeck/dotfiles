#!/bin/sh
# Event-triggered tmux-resurrect save (pane/window created or closed, client detached).
# Debounced, and never replaces the last snapshot with an empty one, which could
# happen while the server shuts down and its windows close one by one.

save=~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh
lock=${TMPDIR:-/tmp}/tmux-save-$(id -u).lock

[ -x "$save" ] || exit 0
sleep 1 # collapse bursts (closing several panes) into one save of the final state

mkdir "$lock" 2>/dev/null || exit 0
trap 'rmdir "$lock"' EXIT

# Server gone or empty: keep the previous snapshot.
[ "$(tmux list-panes -a 2>/dev/null | wc -l)" -gt 0 ] || exit 0

dir=$(tmux show -gqv @resurrect-dir | sed "s|^~|$HOME|")
[ -n "$dir" ] || dir=${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect
prev=$(readlink "$dir/last" 2>/dev/null)
"$save" quiet

# If the server died mid-save, the new snapshot has no panes: point back to the old one.
if [ -n "$prev" ] && ! grep -q '^pane' "$dir/last" 2>/dev/null; then
  ln -fs "$prev" "$dir/last"
fi
exit 0
