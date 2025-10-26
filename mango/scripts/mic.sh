#! /bin/env bash

iDIR="$HOME/.config/mango/scripts/icons"

if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
	pamixer --default-source -m && notify-send -e -u low -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -i "$iDIR/microphone-mute.png" " Microphone:" " Switched OFF"
elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
	pamixer -u --default-source u && notify-send -e -u low -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -i "$iDIR/microphone.png" " Microphone:" " Switched ON"
fi
