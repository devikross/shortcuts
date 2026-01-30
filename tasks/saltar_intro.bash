COMANDO="ptab"

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
IP="$(cat "$BASE_DIR/../../ip.txt" 2>/dev/null)"
[ -z "$IP" ] && { termux-tts-speak -e com.google.android.tts "IP no encontrada"; exit 1; }
HOST="${IP%:*}"
PORT="${IP#*:}"

printf "%s\n" "$COMANDO" | nc -w 3 "$HOST" "$PORT" 2>/dev/null
