#!/usr/bin/env sh

pidof gnome-system-monitor && killall -q gnome-system-monitor && exit 0
/usr/bin/gnome-system-monitor

