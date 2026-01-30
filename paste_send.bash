echo "[INFO] Leyendo clipboard..."
MCB=""
for i in 1 2 3 4 5; do
  MCB="$(termux-clipboard-get)"
  echo "[DEBUG] Intento $i → '$MCB'"
  [ -n "$MCB" ] && break
  sleep 0.2
done

[ -z "$MCB" ] && { echo "[ERROR] Clipboard vacío"; exit 1; }

echo "[INFO] Leyendo ip.txt..."
IP="$(cat ../ip.txt 2>/dev/null)"
[ -z "$IP" ] && { echo "[ERROR] ip.txt vacío o no encontrado"; exit 1; }

HOST="${IP%:*}"
PORT="${IP#*:}"

echo "[INFO] Enviando a $HOST:$PORT"
echo "[DATA] @$MCB"

echo "@$MCB" | nc "$HOST" "$PORT"

echo "[INFO] Limpiando clipboard"
termux-clipboard-set ""
