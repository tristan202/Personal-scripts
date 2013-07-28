#!/bin/sh
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

for d in ~/Documents/Databases/clz*.zip
do
	adb push "$d" /sdcard/
	rm "$d"
done

  sleep 15
done

