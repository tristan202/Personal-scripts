#!/bin/bash

#Little script used to install apps on android devices via
#the android debugging bridge ADB. I use it as a right click
#menu option in tuxcmd, by adding it to the file types.
#
#tristan202 [ad] gmail.com

#Change the title of the terminal window
echo -ne "\033]0;ADB Install\007"

#Functions to show the time used to install
Output() {
echo "$(date -d "1970-01-01 UTC $2 seconds") - $1"
}

Duration() {
  local S=$(echo $FINISH_TIME $BEGIN_TIME | awk '{print$1-$2}')
  ((h=S/3600))
  ((m=S%3600/60))
  ((s=S%60))
  printf "Installation took: %dh:%dm:%ds\n" $h $m $s
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

#The actual installation starts here
Begin
$HOME/android-sdk/platform-tools/adb install -r "$1"
$HOME/android-sdk/platform-tools/adb kill-server
Finish
echo "Done!"
read -p "Press [Enter] to continue."
