#!/usr/bin/env bash
set -euo pipefail

choice="$(
  printf '%s\n' \
    '01  Appearance' \
    '02  Audio Control' \
    '03  Network Connections' \
    '04  Bluetooth' \
    '05  File Manager' \
    '06  System Monitor' \
    '07  Ironbar Config' \
    '08  Sway Config' \
    '09  Regenerate Theme References' \
    '10  Apply Theme Live' \
  | fuzzel --dmenu --prompt='SETTINGS > ' --width=42 --lines=10
)"

case "$choice" in
  '01  Appearance')
    nwg-look
    ;;
  '02  Audio Control')
    pavucontrol
    ;;
  '03  Network Connections')
    nm-connection-editor
    ;;
  '04  Bluetooth')
    blueman-manager
    ;;
  '05  File Manager')
    thunar
    ;;
  '06  System Monitor')
    foot -e sh -c 'btop || htop || top'
    ;;
  '07  Ironbar Config')
    foot -e nvim "$HOME/.config/ironbar/style.css"
    ;;
  '08  Sway Config')
    foot -e nvim "$HOME/.config/sway/config"
    ;;
  '09  Regenerate Theme References')
    "$HOME/.config/lattice/scripts/lattice-generate-theme.sh"
    notify-send "LATTICE THEME" "Theme references regenerated from tokens.env."
    ;;
  '10  Apply Theme Live')
    "$HOME/.config/lattice/scripts/lattice-apply-theme.sh"
    ;;
esac
