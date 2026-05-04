#!/usr/bin/env bash
set -euo pipefail

TOKENS="$HOME/.config/lattice/theme/tokens.env"
BACKUP="$TOKENS.bak"

if [ ! -f "$BACKUP" ]; then
  notify-send "LATTICE THEME" "No tokens.env.bak found."
  exit 1
fi

cp "$BACKUP" "$TOKENS"
"$HOME/.config/lattice/scripts/lattice-apply-theme.sh"
notify-send "LATTICE THEME" "Token backup restored and applied."
