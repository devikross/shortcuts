#!/data/data/com.termux/files/usr/bin/bash
termux-tts-speak -e com.google.android.tts "Enviando"

MCB="$(termux-clipboard-get)"
[ -z "$MCB" ] && exit 1

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
IP="$(cat "$BASE_DIR/../ip.txt" 2>/dev/null)"
[ -z "$IP" ] && exit 1
HOST="${IP%:*}"
PORT="${IP#*:}"

# Solo enviar, sin esperar respuesta
printf "$MCB" | nc -w 3 "$HOST" "$PORT" 2>/dev/null

# Feedback genérico
termux-tts-speak -e com.google.android.tts "Enviado"
termux-clipboard-set ""
