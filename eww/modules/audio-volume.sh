#!/bin/bash

#
# FIXME - avoid using PuleAudio [pactl]
#

symb() {
  local id=$(wpctl status | sed -n "/Sinks:/,\$p" | grep "\*" | grep -oE "[0-9]+" | head -n1)
  local volume=$(wpctl get-volume 61 | grep -oE "[0-9]+" | tail -n1 | xargs -I# echo "#%")

  echo "${volume}"
}

symb

pactl subscribe | while read -r line; do
  sink_changed=$(echo "${line}" | grep "'change' on sink ")
  if [ "$sink_changed" == "" ]; then
    continue
  fi

  symb
done
