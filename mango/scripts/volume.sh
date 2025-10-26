#! /bin/env bash

scripts_dir="$HOME/.config/mango/scripts"
muted=$(pamixer --get-mute)

if [[ $1 == "-i" ]]; then
	pamixer -i 5 --allow-boost --set-limit 150
elif [[ $1 == "-d" ]]; then
	pamixer -d 5
elif [[ $1 == "-m" ]]; then
	if [ "$muted" == "false" ]; then
		pamixer -m 
	elif [ "$muted" == "true" ]; then
		pamixer -u
	fi
fi

"$scripts_dir"/audio_notif.sh
if [[ $muted != "true" ]]; then
	mpv /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
fi
