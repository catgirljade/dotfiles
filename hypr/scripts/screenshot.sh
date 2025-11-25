#! /bin/env bash

if [[ "$1" == "--mode" ]]; then
	mode="$2"
else
	mode="output"
fi

if [ -n "$mode" ]; then
	hyprshot -o $HOME/Pictures/Screenshots/ -z -m "$mode"
fi

