#!/bin/bash

file=/tmp/notifications

init () {
  # How many seconds notification is displayed:
  display_duration=1.0

  deleteAll

  # Stop old tiramisu processes if any:
  pgrep -x tiramisu >/dev/null && killall tiramisu

  tiramisu -o '#source --- #summary --- #body' |
      while read -r line; do

          # Display notification for the duration time:
          sleep "$display_duration"
          #echo -e "$line\n$(cat $file)" > $file
          #cat $file
          #echo "(label :limit-width 50 :text 'HELLO')"
          #text="
                  #(notification :title "cpu" :content "" )
               #"

          #echo $text

          #print_notification "$line" "true"
          #kill "$pid" 2> /dev/null
          #(print_notification "$line" "false") &
          #pid="$!"

          line="$(generateID) --- $line --- $(currentTime)"
          add "$line"
      done
}

deleteAll () {
  > $file
}

deleteOne () {
  id=$1

  cat $file | grep -v "${id}" | tee $file
}

add () {
  echo "$@" >> $file
}

list () {
  cat $file
}

generateID () {
  echo "$(date +%s)"
}

currentTime () {
  echo $(date +"%H:%M")
}

ewwNotifications () {
  echo "
          (box :orientation 'v' :space-evenly false :spacing 10
            $1
          )
       "
}

fileToEwwNotifications () {
  list |
    while read -r line; do
      id=$(awk '{split($0, arr, "---"); print arr[1]}' <<< "$line")
      source=$(awk '{split($0, arr, "---"); print arr[2]}' <<< "$line")
      summary=$(awk '{split($0, arr, "---"); print arr[3]}' <<< "$line")
      body=$(awk '{split($0, arr, "---"); print arr[4]}' <<< "$line")
      time=$(awk '{split($0, arr, "---"); print arr[5]}' <<< "$line")

      notification=$(ewwNotification "${id}" "${source}" "${summary}" "${body}" "${time}")
      echo "$notification"
    done
}

ewwNotification () {
  id=$1
  source=$2
  summary=$3
  body=$4
  time=$5


  icon=""
  case "$(echo $source | xargs)" in
    "Spotify") icon="";;
    "discord") icon="";;
    "Telegram Desktop") icon="";;
    "Internet") icon="";;
  esac

  # beware of characters like single-quote ( ' )
  echo "(notification :id '${id}' :icon '${icon}' :title \"${summary}\" :content \"${body}\" :time '${time}')"
}

help () {
  cat << EOF
  OPTIONS:
    --help
    --init
    --list
    --delete-all
    --delete-one <ID>
    --add <string>
EOF
}

options=$(getopt --options="" --longoptions="help,init,notifications,list,delete-all,delete-one:,add:" -- "$@")

# set --:
# If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional parameters
# are set to the arguments, even if some of them begin with a ‘-’.
eval set -- "$options"

while true; do
  case "$1" in
    --help)       help;;
    --init)       init;;
    --list)       list;;
    --delete-all) deleteAll;;
    --delete-one) deleteOne $2;;
    --add)        add $2;;
    --notifications)  echo $(ewwNotifications "$(fileToEwwNotifications)");;
    --)           break;;
  esac

  shift;
done
