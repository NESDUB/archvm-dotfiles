#!/usr/bin/env bash
set -euo pipefail

cliphist list \
  | fuzzel --dmenu --prompt='CLIP > ' --width=48 --lines=10 \
  | cliphist decode \
  | wl-copy
