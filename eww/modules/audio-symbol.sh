#!/bin/bash

#
# FIXME - avoid using PuleAudio [pactl]
#

symb() {
  local id=$(wpctl status | sed -n "/Sinks:/,\$p" | grep "\*" | grep -oE "[0-9]+" | head -n1)
  local is_muted=$(wpctl get-volume $id | grep "MUTED")

  local active_sink=$(pactl --format=json list sinks | jq '.[] | select(.state == "RUNNING")')
  local headphones_plugged=$(echo $active_sink | jq '.active_port' | grep headphones)


  if [ "${is_muted}" != "" ]; then
    echo "󰖁"
    return
  fi

  if [ "${active_sink}" == "" ]; then
    echo ""
    return
  fi

  if [ "${headphones_plugged}" == "" ]; then
    echo "󰓃"
  else
    echo ""
  fi
}

symb

pactl subscribe | while read -r line; do
  sink_changed=$(echo "${line}" | grep "'change' on sink ")
  if [ "$sink_changed" == "" ]; then
    continue
  fi

  symb
done
