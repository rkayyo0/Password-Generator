#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <account_type>"
    exit 1
fi

account_type=$1


grep_result=$(sudo grep "^${account_type}:" /home/rkayyo/Projects/PasswordGenerator/Passwords.txt)

if [ -z "$grep_result" ]; then
    echo "Account type '$account_type' not found."
else
    echo "$grep_result" | awk -F: '{printf "Username: %s\nPassword: %s\n", $2, $3}'
fi
