#!/usr/bin/env bash
set -euo pipefail

choice="$(
  printf '%s\n' \
    'LOCK' \
    'RELOAD SWAY' \
    'EXIT SWAY' \
    'REBOOT' \
    'SHUTDOWN' \
  | fuzzel --dmenu --prompt='POWER > ' --width=32 --lines=5
)"

case "$choice" in
  'LOCK')
    swaylock -f -c 0b0b0a
    ;;
  'RELOAD SWAY')
    swaymsg reload
    ;;
  'EXIT SWAY')
    swaymsg exit
    ;;
  'REBOOT')
    systemctl reboot
    ;;
  'SHUTDOWN')
    systemctl poweroff
    ;;
esac
