#!/bin/bash

CWD=$(echo $PWD)
filename=$(basename "$fullfile")
xarchiver -x $CWD "$1"
exit 0
