#!/usr/bin/env bash
set -euo pipefail

echo "LATTICE OS STATUS"
echo

echo "SESSION"
printf "User:        %s\n" "$(whoami)"
printf "Host:        %s\n" "$(cat /etc/hostname 2>/dev/null || hostname 2>/dev/null || echo unknown)"
printf "Shell:       %s\n" "${SHELL:-unknown}"
printf "Wayland:     %s\n" "${WAYLAND_DISPLAY:-not set}"
printf "Desktop:     %s\n" "${XDG_CURRENT_DESKTOP:-not set}"
echo

echo "PROCESSES"
pgrep -x sway >/dev/null && echo "Sway:        running" || echo "Sway:        missing"
pgrep -x ironbar >/dev/null && echo "Ironbar:     running" || echo "Ironbar:     missing"
pgrep -x mako >/dev/null && echo "Mako:        running" || echo "Mako:        missing"
pgrep -x wl-paste >/dev/null && echo "Clipboard:   running" || echo "Clipboard:   missing"
pgrep -x nm-applet >/dev/null && echo "NM Applet:   running" || echo "NM Applet:   missing"
pgrep -x pipewire >/dev/null && echo "PipeWire:    running" || echo "PipeWire:    missing"
pgrep -x wireplumber >/dev/null && echo "WirePlumber: running" || echo "WirePlumber: missing"
echo

echo "OUTPUT"
if command -v swaymsg >/dev/null 2>&1; then
  swaymsg -t get_outputs | grep -E '"name"|"current_mode"|"scale"|"active"' | sed 's/^[[:space:]]*//'
else
  echo "swaymsg unavailable"
fi
echo

echo "THEME"
if [ -f "$HOME/.config/lattice/theme/tokens.env" ]; then
  grep '^LATTICE_' "$HOME/.config/lattice/theme/tokens.env"
else
  echo "tokens.env missing"
fi
