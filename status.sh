# SIMPLE BAR# status_command while date +'   %d / %m / %y   󰃭    %X   󱑅 '; do sleep 1; done
# while echo -n "$(swaymsg -t get_tree | jq -r '.. | objects | select(.focused?) | .name')  $(  iw dev | grep "ssid" | awk '{print $2}')   $(ip -4 addr show | awk '/inet / && !/127.0.0.1/ {print $2}' | cut -d/ -f1) 󰩟  $(date +'%d / %m / %y') 󰃭  $( date +'%H:%M' ) 󱑅  $(cat /sys/class/power_supply/BAT0/capacity)% 󱊣 "; do sleep 1; done

while true; do
    # Obtener SSID
    SSID=$(iw dev | grep ssid | awk '{print $2}')
    [ -z "$SSID" ] && SSID="Desconectado"

    # Obtener IP
    IP=$(ip -4 addr show | awk '/inet / && !/127.0.0.1/ {print $2}' | cut -d/ -f1)

    # Obtener nivel de batería
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")

    # Obtener volumen
    VOL=$(pamixer --get-volume)% 

    # Obtener brillo
    BRIGHTNESS=$(brightnessctl -P get)%

    # Obtener título de la ventana activa
    WINDOW=$(swaymsg -t get_tree | jq -r '.. | objects | select(.focused?) | .name')

    # Imprimir información en la barra
    echo -n " $SSID   $IP 󰩟  $(date +'%d / %m / %y') 󰃭  $(date +'%H:%M') 󱑅  $BATTERY% 󱊣  $VOL 󰕾  $BRIGHTNESS 󰃠  $WINDOW "

    sleep 1
done
