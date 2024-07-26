#!bin/bash
######################################################
#Author: Aashutosh 
#
#Created 7-25-2024
#
#Version V1
#
#This script list all the user for all repo of the org
#
#######################################################
#
#
set -e
set -o
#Checks if the directory already exists
if [ ! -d "Results" ]; then
	mkdir -p "Results"
fi
####
#
#MAKE USER TO USE YOUR CORRECT USERNAME AND CORRECT TOKEN 
#MISMATCH WILL ERROR OUT
#
####
# the first argument is the username
username=$1
#this will be the token that you can get on github->settings->developerSetting-> tokens
token=$2
curl -L -H "Authorization: token $token" https://api.github.com/users/$username/repos | jq -r '.[].full_name' > Results/ReposDetails.txt
file="Results/ReposDetails.txt"

# Read each line from the file
while IFS= read -r line; do
	current_line="$line"
	echo "Processing repository: $line"
	echo "The user info for $line is: " >> Results/UserDetails.txt
	curl -L -H "Authorization: token $token" https://api.github.com/repos/$line/collaborators | jq -r '.[].login' >> Results/UserDetails.txt
done < "$file"

echo ""
echo ""
echo "#######################################"
echo "User Details:"
cat Results/UserDetails.txt
echo "#######################################"

