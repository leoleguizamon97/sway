# SIMPLE BAR# status_command while date +'   %d / %m / %y   󰃭    %X   󱑅 '; do sleep 1; done
# while echo -n "$(swaymsg -t get_tree | jq -r '.. | objects | select(.focused?) | .name')  $(  iw dev | grep "ssid" | awk '{print $2}')   $(ip -4 addr show | awk '/inet / && !/127.0.0.1/ {print $2}' | cut -d/ -f1) 󰩟  $(date +'%d / %m / %y') 󰃭  $( date +'%H:%M' ) 󱑅  $(cat /sys/class/power_supply/BAT0/capacity)% 󱊣 "; do sleep 1; done

while true; do

##### Estado de la red ####
    # Obtener SSID
    SSID=$(iw dev | grep ssid | awk '{print $2}')
    [ -z "$SSID" ] && SSID="Desconectado"

    # Obtener IP
    IP=$(ip -4 addr show | awk '/inet / && !/127.0.0.1/ {print $2}' | cut -d/ -f1)

### Estado de la batería ##
    
    # Ver si tiene batería
    LAPTOP=1

    if [ -d "/sys/class/power_supply/BAT0" ]; then
        LAPTOP=0
    fi

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

##### Obtener volumen #####
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
        VOL="󰝟"
    fi
###########################

    # Obtener brillo
    BRIGHTNESS=$(brightnessctl -P get)

    # Cambiar icono dependiendo del brillo
    if [ "$BRIGHTNESS" -gt "60" ]; then
        BRIGHTNESS="$BRIGHTNESS 󰃠"
    elif [ "$BRIGHTNESS" -gt "30" ]; then
        BRIGHTNESS="$BRIGHTNESS 󰃟"
    else
        BRIGHTNESS="$BRIGHTNESS 󰃞"
    fi

######### Basicos #########
    # Obtener título de la ventana activa
    WINDOW=$(swaymsg -t get_tree | jq -r '.. | objects | select(.focused?) | .name')

    # Fecha
    DATE=$(date +"%d / %m / %y")

    # Hora
    TIME=$(date +"%H:%M")
###########################

    # Tipo de barra segun si es portatil o no
    if [ "$LAPTOP" = 0 ]; then
        echo -n " $WINDOW  $SSID    $IP 󰩟  $VOL  $BRIGHTNESS  $BATTERY  $DATE 󰃭  $TIME 󱑅 "
    else
        echo -n " $WINDOW  $SSID    $IP 󰩟  $VOL  $DATE 󰃭  $TIME 󱑅 "
    fi
    sleep 0.3
done

    # Obtener temperatura
    # TEMP=$(cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1/1000}')
