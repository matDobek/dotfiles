#!/bin/sh

# How many seconds notification is displayed:
display_duration=0.5

# Maximum number of characters:
char_limit=150

# Replace app names with nerd font logos
use_nerd_font="false"


# Stop old tiramisu processes if any:
pgrep -x tiramisu >/dev/null && killall tiramisu

print_notification() {
  content=$(echo "$1" | tr '\n' ' ')
  content="(label :limit-width 50 :text '$content')"
  echo "{\"show\": $2, \"content\": \"$content\"}"
}

#tiramisu -o '#source --- #summary --- #body' |
echo '' |
    while read -r line; do

        # Replace app names with icons
        line="$(echo "$line" | sed -r 's/Telegram Desktop//')"
        line="$(echo "$line" | sed -r 's/NordVPN//')"
        line="$(echo "$line" | sed -r 's/VLC//')"
        line="$(echo "$line" | sed -r 's/Kdenlive//')"
        line="$(echo "$line" | sed -r 's/Wifi//')"
        line="$(echo "$line" | sed -r 's/Firefox//')"

        # Cut notification by character limit:
        if [ "${#line}" -gt "$char_limit" ]; then
            line="$(echo "$line" | cut -c1-$((char_limit-1)))…"
        fi

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
    done


currentTime () {
  echo $(date +"%H:%M")
}

notificationInit () {
  home/cr0xd/main/friday/dotfiles/eww/modules/friday--notifications.sh --init
}

notificationList () {
  /home/cr0xd/main/friday/dotfiles/eww/modules/friday--notifications.sh --list
}

notificationAdd () {
  entry=$1

  /home/cr0xd/main/friday/dotfiles/eww/modules/friday--notifications.sh --add="${entry}"
}

notificationDelete () {
  entry_id=$1

  /home/cr0xd/main/friday/dotfiles/eww/modules/friday--notifications.sh --delete="${entry_id}"
}

ewwNotifications () {
  echo "
          (box :orientation 'v' :space-evenly false :spacing 10
            $1
          )
       "
}

ewwNotification () {
  source=$1
  summary=$2
  body=$3
  time=$4

  icon=$source

  echo "(notification :icon '${icon}' :title '${summary}' :content '${body}' :time '${time}')"
}

line="Spotify --- Anthems For A Seventeen Year-Old Girl --- Scott Pilgrim Vs. The World --- $(currentTime)"
notificationAdd "$line"


fileToEwwNotifications () {
  notificationList |
    while read -r line; do
      source=$(awk '{split($0, arr, " --- "); print arr[1]}' <<< "$line")
      summary=$(awk '{split($0, arr, " --- "); print arr[2]}' <<< "$line")
      body=$(awk '{split($0, arr, " --- "); print arr[3]}' <<< "$line")
      time=$(awk '{split($0, arr, " --- "); print arr[4]}' <<< "$line")

      notification=$(ewwNotification "${source}" "${summary}" "${body}" "${time}")
      echo "$notification"
    done
}

echo $(ewwNotifications "$(fileToEwwNotifications)")
