#!/bin/bash

#Little script used to copy file to android devices via
#the android debugging bridge ADB. I use it as a right click
#menu option in tuxcmd, by adding it to the file types.
#
#tristan202 [ad] gmail.com

#Change the title of the terminal window
echo -ne "\033]0;ADB Push\007"

#Functions to show the time used to copy
Output() {
  echo "$(date -d "1970-01-01 UTC $2 seconds") - $1"
}

Duration() {
  local S=$(echo $FINISH_TIME $BEGIN_TIME | awk '{print$1-$2}')
  ((h=S/3600))
  ((m=S%3600/60))
  ((s=S%60))
  printf "Pushing took: %dh:%dm:%ds\n" $h $m $s
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

#Copying starts here
Begin
$HOME/android-sdk/platform-tools/adb push "$1" /sdcard/
echo "Done!"
Finish
read -p "Press [Enter] to continue."
