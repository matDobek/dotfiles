#!/bin/sh

workspaces=($(wmctrl -d | awk '{print $12}'))

xprop -spy -root _NET_CURRENT_DESKTOP | while read -r _ _ workspace_index; do
  wk=${workspaces[$workspace_index]}
  rslt="(box :spacing 5 "

  for i in "${!workspaces[@]}"; do
    icon="0"

    if ((i == workspace_index)); then
      icon="1"
    fi

    rslt+="(workspace :active { ${icon} == \"1\" }) "
  done

  rslt+=")"

  echo $rslt
done
