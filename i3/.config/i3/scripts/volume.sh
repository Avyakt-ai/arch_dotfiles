#!/bin/sh

# Increment, decrement, or mute the volume using PulseAudio and send a notification

case $1 in
	up)
		# Increase the volume by 5%
		pactl set-sink-volume @DEFAULT_SINK@ +5%
		;;
	down)
		# Decrease the volume by 5%
		pactl set-sink-volume @DEFAULT_SINK@ -5%
		;;
	mute)
		# Toggle mute
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		;;
esac

# Get the current volume and mute status
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
HIGH=0

send_notification() {
	if [ "$MUTE" = "yes" ]; then
		ICON="audio-volume-mute"
		TEXT="Currently muted"
	else
		if [ "$VOLUME" -lt 33 ]; then
			ICON="audio-volume-low"
		elif [ "$VOLUME" -lt 66 ]; then
			ICON="audio-volume-medium"
		elif [ "$VOLUME" -lt 100 ]; then
			ICON="audio-volume-high"
		else
			HIGH=1
		fi
		TEXT="Currently at ${VOLUME}%"
	fi
	if [ "$HIGH" = 0 ]; then
		dunstify -a "Volume" -r 9993 -h int:value:"$VOLUME" -i "$ICON" "$TEXT" "$volume" -t 2000
	else
		TEXT="VOL KAM KAR LE BKL"
		dunstify -u critical -a "Volume" -r 9993 -h int:value:"$VOLUME" "$TEXT" "$volume" 
	fi



}

send_notification

