#!/bin/sh
# Debounced resurrect save that never replaces the snapshot with an empty one
# (happens while the server shuts down and its windows close one by one).

save=~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh
lock=${TMPDIR:-/tmp}/tmux-save-$(id -u).lock

[ -x "$save" ] || exit 0
sleep 1

mkdir "$lock" 2>/dev/null || exit 0
trap 'rmdir "$lock"' EXIT

[ "$(tmux list-panes -a 2>/dev/null | wc -l)" -gt 0 ] || exit 0

dir=$(tmux show -gqv @resurrect-dir | sed "s|^~|$HOME|")
[ -n "$dir" ] || dir=${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect
prev=$(readlink "$dir/last" 2>/dev/null)
"$save" quiet

# Server died mid-save: keep the previous snapshot
if [ -n "$prev" ] && ! grep -q '^pane' "$dir/last" 2>/dev/null; then
  ln -fs "$prev" "$dir/last"
fi
exit 0
