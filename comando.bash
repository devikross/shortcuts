#!/data/data/com.termux/files/usr/bin/bash
termux-tts-speak -e com.google.android.tts "Selecciona acción"

# Lista de acciones
declare -A acciones=(
    [1]="ptab"
    [2]="pspace"
    [3]="penter"
    [4]="pback"
    [5]="telNext"
    [6]="apagar"
    [7]="salir"
)

# Nombres en español para mostrar
declare -A nombres=(
    [1]="Saltar segmento"
    [2]="Pausar/Reanudar"
    [3]="Siguiente video"
    [4]="Video anterior"
    [5]="Siguiente en Telegram"
    [6]="Apagar"
    [7]="Salir"
)

echo "Opciones:"
for i in "${!nombres[@]}"; do
    echo "$i) ${nombres[$i]}"
done

# Leer selección
read -p "Elige un número: " sel
COMANDO="${acciones[$sel]}"

if [ -z "$COMANDO" ]; then
    termux-tts-speak -e com.google.android.tts "Selección inválida"
    exit 1
fi

# Leer IP
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
IP="$(cat "$BASE_DIR/../ip.txt" 2>/dev/null)"
[ -z "$IP" ] && { termux-tts-speak -e com.google.android.tts "IP no encontrada"; exit 1; }
HOST="${IP%:*}"
PORT="${IP#*:}"

# Enviar comando al server
printf "%s\n" "$COMANDO" | nc -w 3 "$HOST" "$PORT" 2>/dev/null

termux-tts-speak -e com.google.android.tts "Comando enviado: $COMANDO"
