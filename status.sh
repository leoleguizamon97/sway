CHASSIS=$(hostnamectl chassis)

while true; do

#### Estado de la red ####
	
	# Obtener la conexión activa
	ACTIVE_CONNECTION=$(nmcli -t device | grep ':connected' | head -n1)

	DEVICE=$(echo "$ACTIVE_CONNECTION" | cut -d: -f1)
	TYPE=$(echo "$ACTIVE_CONNECTION" | cut -d: -f2)

	if [ "$TYPE" = "wifi" ]; then
		SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
		SSID="$SSID 󰤨"
	elif [ "$TYPE" = "ethernet" ]; then
		if [[ "$DEVICE" == enx* ]] || [[ "$DEVICE" == usb* ]]; then
			SSID="Bridged 󰌘"
		else
			SSID="$DEVICE 󰈀"
		fi
	elif [ "$TYPE" = "loopback" ]; then
		SSID="Offline 󰌙"
	else
		SSID="Unknown "
	fi

	# Obtener IP de conexión activa
	IP=$(nmcli -t -f IP4.ADDRESS device show "$DEVICE" | cut -d: -f2)

	if [ "$TYPE" = "loopback" ]; then
		IP="$IP 󱦂"
	else
		IP="$IP 󰩟"
	fi

#### Estado de la batería ####

	# Obtener fuente de energía
	AC=$(cat /sys/class/power_supply/AC0/online)
	
	# Obtener nivel de batería
	BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
	# Cambiar icono dependiendo del nivel de batería
	if [ "$BATTERY" -gt "90" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰂅' || echo '󰁹' )"
	elif [ "$BATTERY" -gt "80" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰂊' || echo '󰂁' )"
	elif [ "$BATTERY" -gt "70" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰢞' || echo '󰂀' )"
	elif [ "$BATTERY" -gt "60" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰂉' || echo '󰁿' )"
	elif [ "$BATTERY" -gt "50" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰢝' || echo '󰁾' )"
	elif [ "$BATTERY" -gt "40" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰂈' || echo '󰁽' )"
	elif [ "$BATTERY" -gt "30" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰂇' || echo '󰁼' )"
	elif [ "$BATTERY" -gt "20" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰂆' || echo '󰁻' )"
	elif [ "$BATTERY" -gt "10" ]; then
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰢜' || echo '󰁺' )"
	else
		BATTERY="$BATTERY $( [ "$AC" -eq 1 ] && echo '󰢟' || echo '󰂃' )"
	fi

#### Obtener volumen ####

	VOL="$(pactl list sinks | grep -om 1 '[0-9]\+%' | awk '{sum += $1} END {if (NR > 0) print int(sum/NR)}')"

	# Cambiar icono dependiendo del volumen
	if [ "$VOL" -gt "50" ]; then
		VOL="$VOL 󰕾"
	elif [ "$VOL" -gt "20" ]; then
		VOL="$VOL 󰖀"
	elif [ "$VOL" -eq "0" ]; then
		VOL="$VOL 󰝟"
	else
		VOL="$VOL 󰕿"
	fi

	# Detectar si el audio está muteado
	IS_MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

	if [ "$IS_MUTED" != "no" ]; then
		VOL="No Audio 󰝟"
	fi
	
#### Obtener brillo ####
	SCREEN=false
	if [ "$CHASSIS" = "laptop" ] || [ "$CHASSIS" = "convertible" ] || [ "$CHASSIS" = "tablet" ] || [ "$CHASSIS" = "handset" ]; then
		SCREEN=true
	fi
	if [ "$SCREEN" = true ]; then
		# Obtener brillo
		BRIGHTNESS=$(brightnessctl get)
		MAX_BRIGHTNESS=$(brightnessctl max)

		# Normalizar brillo
		BRIGHTNESS=$(( $BRIGHTNESS * 100 / $MAX_BRIGHTNESS ))

		# Cambiar icono dependiendo del brillo
		if [ "$BRIGHTNESS" -gt "60" ]; then
			BRIGHTNESS="$BRIGHTNESS 󰃠"
		elif [ "$BRIGHTNESS" -gt "30" ]; then
			BRIGHTNESS="$BRIGHTNESS 󰃟"
		else
			BRIGHTNESS="$BRIGHTNESS 󰃞"
		fi
	fi

#### Datos basicos ####

	# Obtener título de la ventana activa
	WINDOW=$(swaymsg -t get_tree | jq -r '.. | objects | select(.focused?) | .name' | awk -F ' - ' '{ print $NF }')

	# Fecha
	DATE=$(date +"%d / %m / %y ")󰃭

	# Hora
	TIME=$(date +"%H:%M ")󱑅

	# Obtener temperatura
	TEMP=100
	TEMP=""
	for zone in /sys/class/thermal/thermal_zone*; do
		type=$(<"$zone/type")
		if [[ "$type" == "x86_pkg_temp" ]]; then
			raw_temp=$(<"$zone/temp")
			TEMP=$(awk "BEGIN { printf \"%.1f\", $raw_temp / 1000 }")
			break
		fi
	done
	
	TEMP=$(sensors | awk '/Core 0:/ { print $3; exit }' | tr -d '+°C')
	
	if [ "$TEMP" -ge 65 ]; then
		TEMP="$TEMP󰔄 "
	elif [ "$TEMP" -ge 50 ]; then
		TEMP="$TEMP󰔄 "
	elif [ "$TEMP" -ge 40 ]; then
		TEMP="$TEMP󰔄 "
	else
		TEMP="$TEMP󰔄 "
	fi
	
#### Imprimir barra ####

	# Tipo de barra segun segun chasis
	if [ "$CHASSIS" = "vm" ]; then
		echo -n " $WINDOW  $SSID  $IP    $DATE   $TIME "
	elif [ "$CHASSIS" = "desktop" ]; then
		echo -n " $WINDOW  $SSID  $IP  $VOL  $TEMP  $DATE   $TIME "
	elif [ "$SCREEN" = true ]; then
		echo -n " $WINDOW  $SSID  $IP  $VOL  $BRIGHTNESS  $BATTERY  $TEMP  $DATE   $TIME "
	else
		echo -n " $WINDOW  $SSID  $IP  $VOL  $DATE   $TIME "
	fi
	sleep 0.5

done

