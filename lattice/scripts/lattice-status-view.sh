#!/usr/bin/env bash
set -euo pipefail

foot -e sh -c "$HOME/.config/lattice/scripts/lattice-status.sh; echo; read -r -p 'Press Enter to close...'"
