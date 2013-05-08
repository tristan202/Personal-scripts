#!/bin/bash

echo -ne "\033]0;Upgrade Lubuntu\007"

Output() {
  echo "$(date -d "1970-01-01 UTC $2 seconds") - $1"
}

Duration() {
  local S=$(echo $FINISH_TIME $BEGIN_TIME | awk '{print$1-$2}')
  ((h=S/3600))
  ((m=S%3600/60))
  ((s=S%60))
  printf "Upgrade took: %dh:%dm:%ds\n" $h $m $s
}

Begin() {
  BEGIN_TIME=$(date +%s)
  Output Begin $BEGIN_TIME "$1"
}

Finish() {
  FINISH_TIME=$(date +%s)
  Output Finished $FINISH_TIME "$1"
  Duration
}
clear
echo ""
echo 'Write sudo password (will not be displayed) and hit enter'
read -s password
sudo -k                         # remove previous sudo timestamp
echo $password | sudo -v -S     # create a new one for 15 minutes
echo ""

echo "Updating!"
Begin
sleep 1
sudo apt-get update
echo "Upgrading!"
sudo apt-get -y upgrade
Finish
echo "Done!"
read -p "Press [Enter] to continue."
