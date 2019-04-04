script_name=${BASH_SOURCE[0]}
for pid in $(pidof -x $script_name); do
    if [ $pid != $$ ]; then
        kill -9 $pid
    fi 
done
pkill -f pulseaudio_tail
killall -q polybar

while pgrep -x wal >/dev/null; do sleep 1; done
while pgrep -x polybar >/dev/null; do sleep 1; done
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar0 &
  done
else
  polybar --reload bar0 &
fi
