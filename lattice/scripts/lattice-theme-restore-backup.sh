#!/usr/bin/env bash
set -euo pipefail

BACKUP_ROOT="$HOME/.config/lattice/backups"

choice="$(
  find "$BACKUP_ROOT" -maxdepth 1 -type d -name 'theme-apply-*' -printf '%f\n' 2>/dev/null \
    | sort -r \
    | fuzzel --dmenu --prompt='RESTORE > ' --width=48 --lines=10
)"

[ -z "${choice:-}" ] && exit 0

backup="$BACKUP_ROOT/$choice"

[ -f "$backup/ironbar-style.css" ] && cp "$backup/ironbar-style.css" "$HOME/.config/ironbar/style.css"
[ -f "$backup/fuzzel.ini" ] && cp "$backup/fuzzel.ini" "$HOME/.config/fuzzel/fuzzel.ini"
[ -f "$backup/foot.ini" ] && cp "$backup/foot.ini" "$HOME/.config/foot/foot.ini"
[ -f "$backup/mako-config" ] && cp "$backup/mako-config" "$HOME/.config/mako/config"

pkill ironbar || true
SWAYSOCK="$(ls /run/user/1000/sway-ipc.*.sock | head -1)"
swaymsg -s "$SWAYSOCK" exec ironbar >/dev/null

pkill mako || true
mako >/dev/null 2>&1 &

notify-send "LATTICE THEME" "Restored backup: $choice"
