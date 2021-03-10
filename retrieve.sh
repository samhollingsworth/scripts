#!/bin/bash

# Args: IP Address, App Name
if [ $# -lt 2 ]
then
    echo "ERROR: Incorrect number of arguments; 2 required"
    exit
fi

ip=$1
appName=$2

echo "Forwarding SSH connections over USB..."
`iproxy 2222 22`

#Open new terminal

echo "Listing all installed applications..."
`./dump.py -l`

echo "Target App Indentifier: "
read identifier
`./dump.py $identifier`

echo "Launching app..."
echo "Saving IPA file to frida-ios-dump directory..."

echo "Creating directory..."
`mkdir /Users/samhollingsworth/Documents/Projects/Hacking/Apps/$appName`

echo "Moving IPA file to newly created directory..."
`mv $appName.ipa /Users/samhollingsworth/Documents/Projects/Hacking/Apps/$appName`

echo "Moving to newly created directory.."
`cd /Users/samhollingsworth/Documents/Projects/Hacking/Apps/$appName`

echo "Creating a copy of IPA..."
`cp $appName.ipa $appNameCopy.ipa`

echo "Extracting application files.."
`mv $appName.ipa $appName.zip`
`unzip $appName.zip`
`mkdir $appName\Files`
`mv Payload/$appName.app/* $appName\Files`
echo "IPA Retrieval is complete. Files are located in $appName\Files"
