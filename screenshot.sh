# Ruta y nombre de archivo
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILENAME="$DIR/ss$(date +'%d%m%y-%H%M%S').png"

case $1 in
	0)
		# Capturar área seleccionada
		AREA=$(slurp)
		if [ -z "$AREA" ]; then
			notify-send -u normal "Captura cancelada" "No se seleccionó un área válida"
			exit 1
		fi

		grim -g "$AREA" "$FILENAME"

		# Copiar al portapapeles
		wl-copy < "$FILENAME"
		notify-send -u low "Captura de pantalla - Área seleccionada" "$FILENAME"

		;;	
	1)	
		# Capturar pantalla completa
		grim "$FILENAME"

		# Copiar al portapapeles
		wl-copy < "$FILENAME"
		notify-send -u low "Captura de pantalla - Pantalla completa" "$FILENAME"
		;;
	*)
		notify-send -u critical "Opcion no valida"
		;;
esac