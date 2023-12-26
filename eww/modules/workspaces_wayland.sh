#!/bin/bash

function generete_eww {
  local active_workspace=$(($1))
  local workspaces=("${@:2}")

  rslt="(box :class \"workspace\" :spacing 5"

  for i in "${!workspaces[@]}"; do
    local current=${workspaces[$i]}
    local next=${workspaces[$(($i + 1))]}

    if (( ${active_workspace} == ${current} )); then
      rslt+=" (workspace :current true :active true)"
    else
      rslt+=" (workspace :current false :active true)"
    fi

    if [ "$next" != "" ]; then
      for (( j=${workspaces[i]} + 1; j < ${workspaces[i+1]}; j++ )); do
        rslt+=" (workspace :current false :active false)"
      done
    fi
  done

  rslt+=")"

  echo $rslt
}

function put {
  local x="$1"
  local xs=("${@:2}")

  xs+=(${x})

  for x in "${xs[@]}"; do
    echo "${x}"
  done | uniq -u | sort -g | xargs echo
}

function drop {
  local e="$1"
  local xs=("${@:2}")

  for x in "${xs[@]}"; do
    if [ "$x" != "$e" ]; then
      echo "${x}"
    fi
  done | xargs echo
}

workspaces=($(hyprctl workspaces -j | jq '.[] | select(.id > 0) | .id' | sort -g))
active_workspace=$(hyprctl activeworkspace -j | jq .id)

generete_eww "${active_workspace}" "${workspaces[@]}"

socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  IFS=">>"; arr=($line); unset IFS

  command="${arr[0]}"
  workspace_no="${arr[2]}"

  case ${command} in
    "workspace")
      active_workspace="${workspace_no}"
      generete_eww "${active_workspace}" "${workspaces[@]}"
      ;;
    "createworkspace")
      workspaces=($(put "${workspace_no}" "${workspaces[@]}"))
      generete_eww "${active_workspace}" "${workspaces[@]}"
      ;;
    "destroyworkspace")
      workspaces=($(drop "${workspace_no}" "${workspaces[@]}"))
      generete_eww "${active_workspace}" "${workspaces[@]}"
      ;;
    *)
      :
      ;;
  esac
done
