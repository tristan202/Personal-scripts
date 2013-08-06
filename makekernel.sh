#!/bin/bash

echo -ne "\033]0;Compiling Kernel\007"

clear
echo ""
echo 'Write sudo password (will not be displayed) and hit enter'
read -s password
sudo -k                         # remove previous sudo timestamp
echo $password | sudo -v -S     # create a new one for 15 minutes
echo ""

sudo /home/tristan202/bin/makekernel2.sh

exit 0
