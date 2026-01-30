#!/data/data/com.termux/files/usr/bin/bash
termux-tts-speak -e com.google.android.tts "Enviando"

# Leer clipboard con reintentos
MCB=""
for i in 1 2 3 4 5; do
  MCB="$(termux-clipboard-get)"
  [ -n "$MCB" ] && break
  sleep 0.2
done
[ -z "$MCB" ] && { termux-tts-speak -e com.google.android.tts "Clipboard vacío"; exit 1; }

# Leer IP
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
IP="$(cat "$BASE_DIR/../ip.txt" 2>/dev/null)"
[ -z "$IP" ] && { termux-tts-speak -e com.google.android.tts "IP no encontrada"; exit 1; }
HOST="${IP%:*}"
PORT="${IP#*:}"

# Solo enviar, sin esperar respuesta
printf "@@%s\n" "$MCB" | nc -w 3 "$HOST" "$PORT" 2>/dev/null

# Feedback genérico
termux-tts-speak -e com.google.android.tts "Enviado"
termux-clipboard-set ""
