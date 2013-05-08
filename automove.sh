#!/bin/sh

#Ugly script to move various files from my Downloads
#folder to other places. It is run as a startup process,
#and runs every 15 seconds. Another approach could
#be to remove the while loop, and add it as a cron job.
#
#tristan202 [ad] gmail.com

while [ 1 ]; do
for t in ~/Downloads/*.torrent
do
	mv "$t" ~/.config/rtorrent/watch/start
done

for m in ~/Downloads/*.meta
do
	mv "$t" ~/.config/rtorrent/watch/start
done

for a in ~/Downloads/*.apk
do
	mv "$a" ~/android/ApkRename/input
	cd ~/android/ApkRename
	./apkbatchrename
	rm ~/android/ApkRename/input/*.apk
done

for b in ~/android/ApkRename/output/*.apk
do
	mv "$b" ~/android/apks
done

for i in ~/android/apks/Unknown*.apk
do
	rm "$i"
done
  sleep 15
done

