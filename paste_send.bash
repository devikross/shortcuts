MCB=""
for i in 1 2 3 4 5; do
  MCB="$(termux-clipboard-get)"
  [ -n "$MCB" ] && break
  sleep 0.2
done
[ -z "$MCB" ] && exit 1

IP=$(cat ../ip.txt)
echo "@$MCB" | nc ${IP%:*} ${IP#*:}
termux-clipboard-set ""
