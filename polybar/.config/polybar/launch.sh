#!/usr/bin/env bash

# Kill all running polybar instances
killall -q polybar

# Wait until all polybar instances have stopped
while pgrep -u $(id -u) -x polybar >/dev/null; do sleep 1; done

# Launch polybar on each connected monitor
if type xrandr >/dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload toph &
  done
else
  polybar --reload toph &
fi
