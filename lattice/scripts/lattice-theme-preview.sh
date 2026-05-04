#!/usr/bin/env bash
set -euo pipefail

TOKENS="$HOME/.config/lattice/theme/tokens.env"

if [ ! -f "$TOKENS" ]; then
  notify-send "LATTICE THEME" "tokens.env not found."
  exit 1
fi

source "$TOKENS"

cat <<PREVIEW
LATTICE THEME PREVIEW

BG          #$LATTICE_BG
DESKTOP     #$LATTICE_DESKTOP
ACTIVE      #$LATTICE_ACTIVE
INK         #$LATTICE_INK
INK SOFT    #$LATTICE_INK_SOFT
INK FAINT   #$LATTICE_INK_FAINT
ACCENT      #$LATTICE_ACCENT
WARN        #$LATTICE_WARN
ERROR       #$LATTICE_ERROR
BLUE        #$LATTICE_BLUE

Current flow:
tokens.env → generate references → wire live configs → reload shell
PREVIEW
