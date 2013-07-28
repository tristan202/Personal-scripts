#!/bin/bash

echo -ne "\033]0;ADB Push\007"
export PATH=${PATH}:/home/tristan202/android-sdk/platform-tools/

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

fbname=`basename "$2"`

Begin
  if pidof -x adb > /dev/null
  then
    echo ""
    echo "ADB server already running, proceeding."
    echo ""
  else
    adb start-server
  fi
if [ "$1"="int" -a "$1" != "ext" ]; then
echo "Pushing $fbname to /sdcard/$fbname"
adb push "$2" /sdcard/
echo "Done!"
Finish
read -p "Press [Enter] to continue."
exit 0
elif [ "$1"="ext" -a "$1" != "int" ]; then
echo "Pushing $fbname to /ext_card/$fbname"
adb push "$2" /ext_card/
echo "Done!"
Finish
read -p "Press [Enter] to continue."
exit 0
fi
