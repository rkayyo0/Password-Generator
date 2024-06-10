#!/bin/bash 

echo "####################################################################################################"
echo

echo "What application would you like to store an account for?"
read accountType 


echo "What would you like to store as the username for this account?"
read username


echo "Please enter the length (in characters) of the password you would like to generate: "
read pwLength

echo "Generating Password of Length $pwLength characters for $accountType under Username: $username"

# Store generated passwords in an array
passwords=()
for p in $(seq 1 5); do 
    passwords+=("$(openssl rand -base64 48 | head -c "$pwLength")")
    # Using openssl command to generate random string of characters in base64 format through whole character range of base64 (48 chars)
    # Then limiting the output to the first pwLength characters
done

# Display generated passwords with indices
for idx in "${!passwords[@]}"; do
    echo "$((idx + 1)). ${passwords[idx]}"
done

# Prompt the user to choose one of the passwords
echo "Which of the 5 Passwords would you like to store? Enter the number (1-5):"
read choice

# Validate the user's choice
if [[ "$choice" =~ ^[1-5]$ ]]; then
    selectedPassword="${passwords[choice - 1]}"
    echo "You selected Password $choice: $selectedPassword"
else
    echo "Invalid choice. Please enter a number between 1 and 5."
fi

echo "Your password for $accountType will be stored in the Passwords file under username $username"
echo "$accountType" >> Passwords.txt
echo "$username" >> Passwords.txt
echo "$selectedPassword" >> Passwords.txt
echo "------------------------------------" >> Passwords.txt

echo
echo "####################################################################################################"
