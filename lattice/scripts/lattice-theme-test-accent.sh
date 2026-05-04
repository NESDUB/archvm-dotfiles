#!/usr/bin/env bash
set -euo pipefail

TOKENS="$HOME/.config/lattice/theme/tokens.env"

cp "$TOKENS" "$TOKENS.bak"

python3 - <<'PY'
from pathlib import Path

p = Path.home() / ".config/lattice/theme/tokens.env"
text = p.read_text()

pairs = {
    'LATTICE_ACTIVE="dcdcd1"': 'LATTICE_ACTIVE="d6ddd6"',
    'LATTICE_ACCENT="50605a"': 'LATTICE_ACCENT="4d655c"',
}

for old, new in pairs.items():
    text = text.replace(old, new)

p.write_text(text)
PY

"$HOME/.config/lattice/scripts/lattice-apply-theme.sh"
notify-send "LATTICE THEME" "Accent test applied. Backup: tokens.env.bak"
