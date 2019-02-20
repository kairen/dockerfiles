#!/bin/sh

set -u

: ${URL:="www.google.com"}
: ${INTERVAL:="5"}

while true; do 
  MSG=$(curl -s --output /dev/null --write "%{http_code} %{size_download} %{time_total} %{speed_download}" ${URL})
  CODE=$(echo ${MSG} | awk '{print $1}')
  SIZE=$(echo ${MSG} | awk '{print $2}')
  TIME=$(echo ${MSG} | awk '{print $3}')
  SPEED=$(echo ${MSG} | awk '{print $4}')
  if [ ${CODE} == "200" ]; then 
    echo "$(date): Downloaded ${SIZE} bytes in ${TIME} seconds(${SPEED} bytes/s)"
    echo "" 
  else
    echo "$(date): Network is unreachable."
    echo "" 
    exit 1
  fi
  sleep ${INTERVAL}
done