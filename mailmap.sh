#! /bin/bash

read -p "Old Commit Email: " OLD_EMAIL
read -p "New Commit Email: " NEW_EMAIL
read -p "New Commit Name: " NEW_NAME

printf "%s <%s> <%s>\n" $NEW_NAME $NEW_EMAIL $OLD_EMAIL > .mailmap