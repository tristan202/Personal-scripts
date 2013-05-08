#!/bin/bash

echo -ne "\033]0;ADB Install\007"

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

Begin
/home/tristan202/android-sdk/platform-tools/adb install -r "$1"
/home/tristan202/android-sdk/platform-tools/adb kill-server
Finish
echo "Done!"
read -p "Press [Enter] to continue."