set -euo pipefail

case $1 in
  prev) symbol="";;
  next) symbol="";;
  icon) symbol="";;
  *)    symbol="";;
esac

function status_to_icon {
  while read -r status; do
    if [ "$status" = "Paused"  ]; then
      echo "$symbol"
    elif [ "$status" = "Playing"  ]; then
      echo "$symbol"
    else
      echo ""
    fi
  done
}

playerctl --player=spotify,mpd status --follow 2>/dev/null | status_to_icon
