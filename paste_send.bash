#!/data/data/com.termux/files/usr/bin/bash

# Leer clipboard
MCB=""
for i in 1 2 3 4 5; do
  MCB="$(termux-clipboard-get)"
  [ -n "$MCB" ] && break
  sleep 0.2
done
[ -z "$MCB" ] && exit 1

# Leer IP
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
IP="$(cat "$BASE_DIR/../ip.txt" 2>/dev/null)"
[ -z "$IP" ] && exit 1
HOST="${IP%:*}"
PORT="${IP#*:}"

# Enviar y esperar confirmación
REPLY=$(printf "@%s\n" "$MCB" | nc -w 15 "$HOST" "$PORT")

# Feedback por voz y limpiar clipboard
if [ "$REPLY" = "OK" ]; then
    termux-tts-speak -e com.google.android.tts "Enviado"
    # termux-clipboard-set "" 
else
    termux-tts-speak -e com.google.android.tts "Error"
fi
