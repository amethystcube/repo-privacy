#!/bin/bash

  TOKEN=$1
  EXPOSED=()
  SAFE=()
  cd ./repos
  for dir in */; do
    dir=${dir%/}
    cd $dir
    COUNT=$(git log | grep "$TOKEN" | wc -l | xargs)
    # printf "### Checking '$dir': $COUNT result(s)\n"
    if [ $(($COUNT)) -gt 0 ]; then
      EXPOSED+=("$dir: $COUNT result(s)")
    else
      SAFE+=("$dir")
    fi
    cd ..
  done
  printf "Safe Repositories\n==============================\n"
  printf '%s\n' "${SAFE[@]}"
  printf "\nExposed Repositories\n==============================\n"
  printf '%s\n' "${EXPOSED[@]}"