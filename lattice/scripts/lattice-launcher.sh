#!/usr/bin/env bash
set -euo pipefail

choice="$(
  printf '%s\n' \
    '01  Terminal' \
    '02  Files' \
    '03  Browser' \
    '04  Settings' \
    '05  Screenshot' \
    '06  Clipboard' \
    '07  Reload Sway' \
    '08  Restart Ironbar' \
    '09  Power Menu' \
  | fuzzel --dmenu --prompt='LATTICE > ' --width=42 --lines=9
)"

case "$choice" in
  '01  Terminal')
    foot
    ;;
  '02  Files')
    thunar
    ;;
  '03  Browser')
    firefox
    ;;
  '04  Settings')
    nwg-look
    ;;
  '05  Screenshot')
    "$HOME/.config/lattice/scripts/lattice-screenshot.sh"
    ;;
  '06  Clipboard')
    "$HOME/.config/lattice/scripts/lattice-clipboard.sh"
    ;;
  '07  Reload Sway')
    swaymsg reload
    ;;
  '08  Restart Ironbar')
    pkill ironbar || true
    swaymsg exec ironbar
    ;;
  '09  Power Menu')
    "$HOME/.config/lattice/scripts/lattice-power.sh"
    ;;
esac
