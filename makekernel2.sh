#!/bin/bash

FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

Output() {
echo "$(date -d "1970-01-01 UTC $2 seconds") - $1"
}

Duration() {
  local S=$(echo $FINISH_TIME $BEGIN_TIME | awk '{print$1-$2}')
  ((h=S/3600))
  ((m=S%3600/60))
  ((s=S%60))
  printf "Compiling took: %dh:%dm:%ds\n" $h $m $s
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

Build390() {
clear
cd ~/source/linux-3.9.0
echo ""
prompt="Do you want to run xconfig? Press [Y] if you do, or [N] to skip it."
echo -n "$prompt"
    echo ""
    read -n1 char
    echo ""
    Begin
    case "$char" in
      [Nn]) echo "" && make clean && make -j3 && make INSTALL_MOD_STRIP=1 modules_install && make INSTALL_MOD_STRIP=1 headers_install && sudo make INSTALL_MOD_STRIP=1 install
 ;;
      [Yy])  echo "" && make xconfig && make clean && make -j3 && make INSTALL_MOD_STRIP=1 modules_install && make INSTALL_MOD_STRIP=1 headers_install && sudo make INSTALL_MOD_STRIP=1 install
 ;;
    esac
echo ""
Finish
echo ""
echo "Done!"
echo ""
read -p "Press [Enter] to continue."
Main
}

Build3810() {
clear
cd ~/source/linux-3.8.11-ck1
echo ""
prompt="Do you want to run xconfig? Press [Y] if you do, or [N] to skip it."
echo -n "$prompt"
    echo ""
    read -n1 char
    echo ""
    Begin
    case "$char" in
      [Nn]) echo "" && make clean && make -j3 && make INSTALL_MOD_STRIP=1 modules_install && make INSTALL_MOD_STRIP=1 headers_install && sudo make INSTALL_MOD_STRIP=1 install
 ;;
      [Yy])  echo "" && make xconfig && make clean && make -j3 && make INSTALL_MOD_STRIP=1 modules_install && make INSTALL_MOD_STRIP=1 headers_install && sudo make INSTALL_MOD_STRIP=1 install
 ;;
    esac
echo ""
Finish
echo ""
echo "Done!"
echo ""
read -p "Press [Enter] to continue."
Main
}

Sync ()
{
clear
Begin
cd ~/source/linux-3.9.0 && git pull
Finish
echo ""
echo "Done!"
echo ""
read -p "Press [Enter] to continue."
Main
}

Reboot ()
{
clear
echo ""
echo "Rebooting in 5"
sleep 1
echo "             4"
sleep 1
echo "             3"
sleep 1
echo "             2"
sleep 1
echo "             1"
sleep 1
echo "Going down for reboot..."
sudo reboot
}

Main ()
{
  clear
  while true
  do
    clear
    line='----------------------------------------'
    echo "$line"
    echo "Linux kernel build script"
    echo ""
    echo "Select from the following functions"
    echo ""
    echo "  S    Sync 3.9 repo"
    echo "  1    Build 3.9.0 kernel"
    echo "  2    Build 3.8.11-ck1 kernel"
    echo "  R    Reboot to test your new kernel"
    echo "  X    Exit"
    echo "$line"
    tput civis
    echo -n "  "
    read -n1 answer
    case "$answer" in
      [Ss]) Sync;;
      [1]) Build390;;
      [2]) Build3810;;
      [Rr]) Reboot;;
      [Xx]) clear
        echo "Live long and prosper... tristan202"
        echo ""
        tput cnorm
      break ;;
    esac
  done
  exit 0
}

Main
