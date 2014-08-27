#!/sbin/sh
busybox rm /system/lib/libc.so
busybox rm /system/lib/libdl.so
busybox rm /system/lib/libm.so
busybox rm /system/lib/libstdc++.so
busybox rm /system/lib/modules/*
return $?
