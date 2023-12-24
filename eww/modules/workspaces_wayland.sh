#!/bin/sh

workspaces=($(hyprctl workspaces -j | jq '.[] | select(.id > 0) | .id' | sort -g))
active_workspace=$(hyprctl activeworkspace -j | jq .id)

rslt="(box :class \"workspace\" :spacing 5 "

for workspace in "${workspaces[@]}"; do
  is_active=false

  if (($active_workspace == workspace)); then
    is_active=true
  fi

  rslt+="(workspace :active { ${is_active} }) "
done

rslt+=")"
echo $rslt
