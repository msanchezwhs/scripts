#!/bin/sh
## Get logged in user
loggedInUser=$(stat -f%Su /dev/console)
icloudaccount=$( defaults read /Users/$loggedInUser/Library/Preferences/MobileMeAccounts.plist Accounts | grep AccountID | cut -d '"' -f 2)

if [ -z "$icloudaccount" ] 
then
    echo "Null"
else
    echo "$icloudaccount"
fi
