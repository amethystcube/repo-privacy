#! /bin/bash

read -p "GitHub Account: " ACCOUNT
read -p "Repository Name: " REPO_NAME

## -- TODO: Choose a branch -- ##
# read -p "Branch: " BRANCH
BRANCH="main"

cd repos/$REPO_NAME

git push --set-upstream git@github.com:$ACCOUNT/$REPO_NAME.git $BRANCH --force

printf "\n==============================\nIf you don't see any errors above this message, then the $REPO_NAME repository has been reconnected to $ACCOUNT's GitHub successfully.\n"