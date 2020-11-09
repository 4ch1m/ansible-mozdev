#!/bin/bash

TMP_FILE=$(mktemp)

find ${1} -iname "messages.json" -exec sh -c "cat '{}' | jq 'keys' >> ${TMP_FILE}" \;

LINES=$(cat ${TMP_FILE} || sort || uniq)

for LINE in ${LINES}; do

  if [[ ${LINE} == *\"*\"* ]]; then
    LINE=${LINE#*\"}
    LINE=${LINE%\"*}

    grep -r "${LINE}" ${1} | grep -vq "messages.json"

    if [ ${?} -gt 0 ]; then
      echo "unused message: '${LINE}'"
      exit 1
    fi
  fi

done
