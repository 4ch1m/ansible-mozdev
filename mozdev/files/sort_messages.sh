#!/bin/bash

find "${1}" -iname "messages.json" -exec bash -c "cat '{}' | jq -S | sponge '{}'" \;
