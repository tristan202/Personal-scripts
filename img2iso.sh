#!/bin/bash

input=$1
stripped=${input%.*}
filename=${stripped##*/}
cwd=$(pwd)
echo -ne "\033]0;IMG 2 ISO\007"

Output() {
  echo "$(date -d "1970-01-01 UTC $2 seconds") - $1"
}

Duration() {
  local S=$(echo $FINISH_TIME $BEGIN_TIME | awk '{print$1-$2}')
  ((h=S/3600))
  ((m=S%3600/60))
  ((s=S%60))
  printf "Conversion took: %dh:%dm:%ds\n" $h $m $s
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

echo "Converting $filename.img to $filename.iso"
echo ""
Begin
echo ""
iat --input="$1"  --output=$filename.iso --iso
echo ""
Finish
filesizein=$(stat -c%s "$1")
filesizeout=$(stat -c%s $cwd/$filename.iso)
echo ""
echo "Size of $filename.img = $filesizein bytes."
echo "Size of $filename.iso = $filesizeout bytes."
echo ""
echo "Would you like to delete the original file?"
    prompt='Press [Y] to delete it, or [N] to quit without deleting it.'
    echo -n "$prompt"
    echo ""
    read -n1 char
    case "$char" in
      [Nn]) echo "" && read -p "Press [Enter] to continue." ;;
      [Yy])  rm $1  && echo "" && echo "$1 deleted" && echo "" && read -p "Press [Enter] to continue." ;;
    esac
  fi

read -p "Press [Enter] to continue."
