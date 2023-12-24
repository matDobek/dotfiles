#!/bin/bash

last_active=$(curl https://api.github.com/users/matDobek/events/public | jq '.[] | .created_at' | head -n1 | xargs -I# date --date=# '+%s')
now=$(date '+%s')
diff=$(( (now - last_active) / (60*60) ))

if (( diff > 24 )); then
  echo ""
else
  echo ${diff}h
fi
