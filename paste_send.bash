echo "[INFO] Clipboard → leyendo"
for i in 1 2 3 4 5; do
  MCB="$(termux-clipboard-get)"
  echo "[DEBUG] intento $i: '$MCB'"
  [ -n "$MCB" ] && break
  sleep 0.2
done
[ -z "$MCB" ] && { echo "[ERROR] Clipboard vacío"; exit 1; }

echo "[INFO] IP → leyendo ip.txt"
IP="$(cat ../../ip.txt 2>/dev/null)"
[ -z "$IP" ] && { echo "[ERROR] ip.txt no encontrado o vacío"; exit 1; }

HOST="${IP%:*}"
PORT="${IP#*:}"

echo "[INFO] Envío → $HOST:$PORT"
echo "[DATA] @$MCB"

printf "@%s\n" "$MCB" | nc -w 1 "$HOST" "$PORT"

echo "[INFO] Clipboard → limpiando"
termux-clipboard-set ""
