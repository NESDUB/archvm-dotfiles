#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/Pictures/Screenshots"

choice="$(
  printf '%s\n' \
    '01  Area to file' \
    '02  Area to clipboard' \
    '03  Fullscreen to file' \
    '04  Fullscreen to clipboard' \
    '05  Area to Swappy' \
  | fuzzel --dmenu --prompt='SHOT > ' --width=36 --lines=5
)"

stamp="$(date +%Y%m%d-%H%M%S)"
file="$HOME/Pictures/Screenshots/shot-$stamp.png"

case "$choice" in
  '01  Area to file')
    grim -g "$(slurp)" "$file"
    notify-send "LATTICE SHOT" "Saved area screenshot."
    ;;
  '02  Area to clipboard')
    grim -g "$(slurp)" - | wl-copy
    notify-send "LATTICE SHOT" "Copied area screenshot."
    ;;
  '03  Fullscreen to file')
    grim "$file"
    notify-send "LATTICE SHOT" "Saved fullscreen screenshot."
    ;;
  '04  Fullscreen to clipboard')
    grim - | wl-copy
    notify-send "LATTICE SHOT" "Copied fullscreen screenshot."
    ;;
  '05  Area to Swappy')
    grim -g "$(slurp)" - | swappy -f -
    ;;
esac
