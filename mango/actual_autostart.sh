#! /bin/env bash
set -euo pipefail

usrAppdir="/usr/share/applications"

# Startup
systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

dex -a -e "$XDG_CURRENT_DESKTOP" &

# starup apps
swaync &
#ags
#rog-control-center
waybar &

#clipboard manager
# wl-paste --type text --watch cliphist store
# wl-paste --type image --watch cliphist store
wl-clip-persist --clipboard regular & 
# $scriptsDir/clipsync.py
elephant &
systemctl --user start walker.service & # auto restart walker because its crashing?

swayidle \
	timeout 300 'gtklock -d' \
	timeout 600 'wlr-dpms off' \
		 resume 'wlr-dpms on' \
	before-sleep 'gtklock -d' &

swww-daemon &

# Discord
dex $usrAppdir/vesktop.desktop &
# Browser
dex $usrAppdir/librewolf.desktop &

