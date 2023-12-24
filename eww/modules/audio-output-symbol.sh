#!/bin/bash

is_muted=$(amixer get Master | grep off)
active_sink=$(pactl --format=json list sinks | jq '.[] | select(.state == "RUNNING")')
headphones_plugged=$(echo $active_sink | jq '.active_port' | grep headphones)


if [ "${is_muted}" != "" ]; then
  echo "󰖁"
  exit
fi

if [ "${active_sink}" == "" ]; then
  echo ""
  exit
fi

if [ "${headphones_plugged}" == "" ]; then
  echo "󰓃"
else
  echo ""
fi
