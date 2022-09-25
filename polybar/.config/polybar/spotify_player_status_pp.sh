# dpolybar-player-status-pp

set -euo pipefail

function status_to_icon {
  while read -r status; do
    if [ "$status" = "Paused"  ]; then
      echo ""
    elif [ "$status" = "Playing"  ]; then
      echo ""
    else
      echo ""
    fi
  done
}

playerctl --player=spotify,mpd status --follow 2>/dev/null | status_to_icon
