#! /bin/env bash

iDIR="$HOME/.config/mango/scripts/icons"

get_volume() {
	volume=$(pamixer --get-volume)
	echo "$volume %"
}

get_icon() {
    current=$(get_volume)
	if [[ "$(pamixer --get-mute)" == "true" ]]; then
        echo "$iDIR/volume-mute.png"
    elif [[ "${current%\%}" -le 30 ]]; then
        echo "$iDIR/volume-low.png"
    elif [[ "${current%\%}" -le 60 ]]; then
        echo "$iDIR/volume-mid.png"
    else
        echo "$iDIR/volume-high.png"
    fi
}

if [[ "$(get_volume)" == "0 %" ]] || [[ $(pamixer --get-mute) == "true" ]]; then
	notify-send -e -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -u low -i "$(get_icon)" " Volume:" " Muted"
else
	notify-send -e -h int:value:"$(get_volume | sed 's/%//')" -h string:x-canonical-private-synchronous:volume_notif -h boolean:SWAYNC_BYPASS_DND:true -u low -i "$(get_icon)" " Volume Level:" " $(get_volume)"
fi

