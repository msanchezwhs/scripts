#!/bin/sh

#!/bin/bash

# Get the list of installed printers and remove old printers
sudo lpstat -p | awk '/^printer/ {
    printerName = "";
    for (i=2; i<=NF; i++) {
        if ($i == "is") break;
        printerName = printerName (printerName == "" ? "" : " ") $i;
    }
    print printerName;
}' | while read -r printer
do
    if [[ "$printer" == WHS* ]] || [[ "$printer" == "High"* ]] || [[ "$printer" == "FollowMe"* ]] || [[ "$printer" == "_20" ]] || [[ "$printer" == "West"* ]] || [[ "$printer" == "Room_110" ]]; then
        echo "Deleting printer: $printer"
        lpadmin -x "$printer"
    fi
done
Sleep 5

# Downloads the PC print deploy Client DMG to temp WARNING MUST BE NAMED EXACTLY AS IT WAS FROM SERVER
curl -L --silent -o /tmp/pc-print-deploy-client[XXX.XXX.XXX.XXX].dmg %MosyleCDNFile%
sleep 5
hdiutil attach /private/tmp/pc-print-deploy-client[XXX.XXX.XXX.XXX].dmg
sleep 2

#installs the print deploy from the PKG inside the DMG.

sudo installer -allowUntrusted -pkg /Volumes/PaperCut\ Print\ Deploy\ Client/PaperCut\ Print\ Deploy\ Client.pkg -target /
sleep 2
diskutil unmount /Volumes/PaperCut\ Print\ Deploy\ Client
echo "Hopfully it is installed..."