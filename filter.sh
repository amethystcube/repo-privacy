#! /bin/bash

cd repos/$1

git filter-repo --quiet --mailmap ../../.mailmap
