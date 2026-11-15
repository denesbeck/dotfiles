#!/bin/sh
# Popup overview of every tmux window with a Claude status; Enter jumps to it.

now=$(date +%s)
list=$(tmux list-windows -a -F '#{@claude_status}	#{@claude_since}	#{session_name}:#{window_index}	#{window_name}' |
  awk -F'\t' -v now="$now" '
    $1 == "" { next }
    {
      rank = ($1 == "waiting") ? 0 : ($1 == "working") ? 1 : 2
      icon = ($1 == "waiting") ? "\033[31m! waiting\033[0m" : ($1 == "working") ? "\033[33m● working\033[0m" : "\033[32m✓ done   \033[0m"
      age = ($2 == "") ? "" : now - $2
      if (age != "") age = (age < 60) ? age "s" : (age < 3600) ? int(age / 60) "m" : int(age / 3600) "h"
      printf "%d\t%s\t%s  %-5s  %-20s %s\n", rank, $3, icon, age, $3, $4
    }' | sort -t'	' -k1,1n | cut -f2-)

if [ -z "$list" ]; then
  echo "No Claude sessions running."
  sleep 1
  exit 0
fi

target=$(printf '%s\n' "$list" |
  fzf --ansi --delimiter='\t' --with-nth=2 --no-sort --reverse --prompt='claude> ' |
  cut -f1)

[ -n "$target" ] && tmux switch-client -t "$target"
exit 0
