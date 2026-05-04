#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/lattice/theme"
BACKUP_DIR="$HOME/.config/lattice/backups/theme-apply-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$BACKUP_DIR"

cp "$HOME/.config/ironbar/style.css" "$BACKUP_DIR/ironbar-style.css"
cp "$HOME/.config/fuzzel/fuzzel.ini" "$BACKUP_DIR/fuzzel.ini"
cp "$HOME/.config/foot/foot.ini" "$BACKUP_DIR/foot.ini"
cp "$HOME/.config/mako/config" "$BACKUP_DIR/mako-config"

"$HOME/.config/lattice/scripts/lattice-generate-theme.sh"

python3 - <<'PY'
from pathlib import Path

home = Path.home()

def replace_top_define_colors(style_path: Path, colors_path: Path):
    text = style_path.read_text()
    color_text = colors_path.read_text().strip()
    lines = text.splitlines()
    start = None
    end = None
    for i, line in enumerate(lines):
        if line.strip().startswith("@define-color"):
            if start is None:
                start = i
            end = i
    if start is None:
        raise SystemExit(f"No @define-color block found in {style_path}")
    new_lines = lines[:start] + color_text.splitlines() + lines[end + 1:]
    style_path.write_text("\n".join(new_lines) + "\n")

def replace_ini_section(config_path: Path, section_path: Path, section_name: str):
    text = config_path.read_text()
    section_text = section_path.read_text().strip()
    lines = text.splitlines()
    out = []
    i = 0
    replaced = False
    target = f"[{section_name}]"
    while i < len(lines):
        line = lines[i]
        if line.strip() == target:
            out.extend(section_text.splitlines())
            i += 1
            while i < len(lines) and not lines[i].strip().startswith("["):
                i += 1
            replaced = True
            continue
        out.append(line)
        i += 1
    if not replaced:
        out.append("")
        out.extend(section_text.splitlines())
    config_path.write_text("\n".join(out) + "\n")

replace_top_define_colors(
    home / ".config/ironbar/style.css",
    home / ".config/lattice/theme/gtk-colors.css"
)
replace_ini_section(
    home / ".config/fuzzel/fuzzel.ini",
    home / ".config/lattice/theme/fuzzel-colors.ini",
    "colors"
)
replace_ini_section(
    home / ".config/foot/foot.ini",
    home / ".config/lattice/theme/foot-colors.ini",
    "colors"
)
PY

pkill ironbar || true
SWAYSOCK="$(ls /run/user/1000/sway-ipc.*.sock | head -1)"
swaymsg -s "$SWAYSOCK" exec ironbar >/dev/null

pkill mako || true
mako >/dev/null 2>&1 &

notify-send "LATTICE THEME" "Theme regenerated, wired, and reloaded."
echo "Applied Lattice theme. Backup: $BACKUP_DIR"
