#!/bin/bash

DIRECTORY=repos

printf "Downloading repositories...\n==============================\n"
sleep 2
if [[ -d "$DIRECTORY" ]]; then
    rm -rf ./$DIRECTORY/*
else
    mkdir ./$DIRECTORY
fi
cd ./repos
curl https://api.github.com/users/$1/repos | grep -o \"$1/.*\" | xargs -I {} git clone --quiet https://github.com/{}.git
