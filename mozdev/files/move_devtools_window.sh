#!/bin/bash

if [ -z "${1+x}" ]; then
  X_COORD=0
else
  X_COORD="${1}"
fi

if [ -z "${2+x}" ]; then
  Y_COORD=0
else
  Y_COORD="${2}"
fi

for i in {1..10}; do
  WINDOW_ID=$(xdotool search --limit 1 --classname "Devtools")

  if [ ${?} -ne 0 ]; then
    sleep 1
  else
    xdotool windowmove ${WINDOW_ID} ${X_COORD} ${Y_COORD}
  fi
done
