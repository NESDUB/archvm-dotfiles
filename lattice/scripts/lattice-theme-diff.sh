#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/lattice/theme"

"$HOME/.config/lattice/scripts/lattice-generate-theme.sh" >/dev/null

{
  echo "LATTICE THEME DIFF"
  echo
  echo "Ironbar colors:"
  diff -u <(grep '^@define-color' "$HOME/.config/ironbar/style.css") "$THEME_DIR/gtk-colors.css" || true
  echo
  echo "Fuzzel colors:"
  diff -u <(awk '/^\[colors\]/{flag=1} flag{print} /^\[/{if(flag && NR!=1 && $0!="[colors]") exit}' "$HOME/.config/fuzzel/fuzzel.ini") "$THEME_DIR/fuzzel-colors.ini" || true
  echo
  echo "Foot colors:"
  diff -u <(awk '/^\[colors\]/{flag=1} flag{print} /^\[/{if(flag && NR!=1 && $0!="[colors]") exit}' "$HOME/.config/foot/foot.ini") "$THEME_DIR/foot-colors.ini" || true
} | less -R
