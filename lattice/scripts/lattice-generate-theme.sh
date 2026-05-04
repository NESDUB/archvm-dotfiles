#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/lattice/theme"
IRONBAR_DIR="$HOME/.config/ironbar"
FUZZEL_DIR="$HOME/.config/fuzzel"
FOOT_DIR="$HOME/.config/foot"
MAKO_DIR="$HOME/.config/mako"

source "$THEME_DIR/tokens.env"

mkdir -p "$IRONBAR_DIR" "$FUZZEL_DIR" "$FOOT_DIR" "$MAKO_DIR"

cat > "$THEME_DIR/gtk-colors.css" <<CSS
@define-color bg rgba(243, 243, 239, 0.88);
@define-color bg_solid #$LATTICE_BG;
@define-color cell rgba(255, 255, 255, 0.34);
@define-color cell_hot #$LATTICE_CELL_HOT;
@define-color active #$LATTICE_ACTIVE;
@define-color ink #$LATTICE_INK;
@define-color ink_soft #$LATTICE_INK_SOFT;
@define-color ink_faint #$LATTICE_INK_FAINT;
@define-color icon_soft #6f7068;
@define-color icon_active #$LATTICE_INK;
@define-color line rgba(11, 11, 10, 0.16);
@define-color line_strong rgba(11, 11, 10, 0.34);
@define-color accent #$LATTICE_ACCENT;
@define-color warn #$LATTICE_WARN;
@define-color error #$LATTICE_ERROR;
@define-color blue #$LATTICE_BLUE;
CSS

cat > "$THEME_DIR/fuzzel-colors.ini" <<INI
[colors]
background=${LATTICE_BG}f2
text=${LATTICE_INK}ff
prompt=${LATTICE_INK_SOFT}ff
placeholder=${LATTICE_INK_FAINT}ff
input=${LATTICE_INK}ff
match=${LATTICE_INK}ff
selection=${LATTICE_ACTIVE}ff
selection-text=${LATTICE_INK}ff
selection-match=${LATTICE_INK}ff
border=${LATTICE_LINE}
INI

cat > "$THEME_DIR/foot-colors.ini" <<INI
[colors]
foreground=$LATTICE_INK
background=$LATTICE_BG

regular0=$LATTICE_INK
regular1=$LATTICE_ERROR
regular2=$LATTICE_ACCENT
regular3=$LATTICE_WARN
regular4=$LATTICE_BLUE
regular5=5d5368
regular6=4f6b68
regular7=$LATTICE_ACTIVE

bright0=$LATTICE_INK_SOFT
bright1=8b4a44
bright2=65766e
bright3=a68e4d
bright4=60798b
bright5=71667d
bright6=63807c
bright7=ffffff

selection-foreground=$LATTICE_INK
selection-background=$LATTICE_ACTIVE
urls=$LATTICE_BLUE
INI

cat > "$THEME_DIR/mako-colors.conf" <<CONF
background-color=#${LATTICE_BG}f2
text-color=#${LATTICE_INK}ff
border-color=#${LATTICE_LINE}
CONF

echo "Generated Lattice theme references from tokens.env"
