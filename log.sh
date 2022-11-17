#!/bin/bash

  REPO=$1
  TOKEN=$2

  cd ./repos/$REPO

  git log | grep $TOKEN