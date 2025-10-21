#! /bin/bash
set +e

# Startup
systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# starup apps
nm-applet --indicator &
swaync &
#ags
blueman-applet &
#rog-control-center
waybar &

#clipboard manager
# wl-paste --type text --watch cliphist store
# wl-paste --type image --watch cliphist store
wl-clip-persist --clipboard regular & 
# $scriptsDir/clipsync.py
elephant &
walker --gapplication-service &

swayidle -w \
	timeout 300 'gtklock' \
	timeout 600 'wlr-dpms off"' \
		 resume 'wlr-dpms on"' \
	before-sleep 'gtklock' &

# fcitx5
fcitx5-remote -r &
fcitx5 -d --replace &
fcitx5-remote -r &

/usr/libexec/xfce-polkit & 
swww-daemon &

# Discord
vesktop &
# Browser
librewolf &
