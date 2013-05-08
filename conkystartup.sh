#!/bin/bash
sleep 10
conky -c ~/.conky/main &
sleep 5
conky -c ~/.conky/clock &
sleep 5
conky -c ~/.conky/processes
