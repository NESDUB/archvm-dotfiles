#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/lattice/theme"

"$HOME/.config/lattice/scripts/lattice-generate-theme.sh" >/dev/null

extract_ini_section() {
  local file="$1"
  local section="$2"

  awk -v section="$section" '
    $0 == "[" section "]" {
      flag=1
      print
      next
    }

    flag && /^\[/ {
      exit
    }

    flag {
      print
    }
  ' "$file"
}

{
  echo "LATTICE THEME DIFF"
  echo
  echo "Ironbar colors:"
  diff -u \
    <(grep '^@define-color' "$HOME/.config/ironbar/style.css") \
    "$THEME_DIR/gtk-colors.css" || true

  echo
  echo "Fuzzel colors:"
  diff -u \
    <(extract_ini_section "$HOME/.config/fuzzel/fuzzel.ini" "colors") \
    "$THEME_DIR/fuzzel-colors.ini" || true

  echo
  echo "Foot colors:"
  diff -u \
    <(extract_ini_section "$HOME/.config/foot/foot.ini" "colors") \
    "$THEME_DIR/foot-colors.ini" || true
} | less -R
