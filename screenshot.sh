# Ruta y nombre de archivo
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILENAME="$DIR/ss$(date +'%d%m%y-%H%M%S').png"

notify-send $1

case $1 in
	0)
		# Capturar área seleccionada
		grim -g "$(slurp)" "$FILENAME"
		
		# Copiar al portapapeles
		wl-copy < "$FILENAME"
		notify-send "Captura de pantalla - Area seleccionada" "$FILENAME"
		;;	
	1)	
		# Capturar pantalla completa
		grim "$FILENAME"

		# Copiar al portapapeles
		wl-copy < "$FILENAME"
		notify-send "Captura de pantalla - Pantalla completa" "$FILENAME"
		;;
	*)
		notify-send "Opcion no valida"
		;;
esac