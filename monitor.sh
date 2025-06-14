#!/bin/bash

echo "== SLOT SYNC =="
start_local=$(curl -s -X POST http://localhost:8899 -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1,"method":"getSlot"}' | jq .result)
start_remote=$(curl -s -X POST https://api.mainnet-beta.solana.com -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1,"method":"getSlot"}' | jq .result)

sleep 10

end_local=$(curl -s -X POST http://localhost:8899 -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1,"method":"getSlot"}' | jq .result)
end_remote=$(curl -s -X POST https://api.mainnet-beta.solana.com -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1,"method":"getSlot"}' | jq .result)

local_diff=$((end_local - start_local))
remote_diff=$((end_remote - start_remote))
slots_per_sec=$(echo "scale=2; $local_diff / 10" | bc)
behind=$((end_remote - end_local))

echo "🧠 Local Slot: $end_local"
echo "🌐 Remote Slot: $end_remote"
echo "⚡️ Slots/sec: $slots_per_sec"
echo "🔻 Slots Behind: $behind"

echo ""
echo "--- DISK (iostat) ---"
iostat -xmdz 1 1 | grep nvme

echo ""
echo "--- RAM (free) ---"
free -g

echo ""
echo "--- CPU Load & Validator Threads ---"
top -b -n1 -o %CPU | head -n 15 | grep -E "PID|agave|COMMAND"

echo ""
echo "--- NETWORK ---"
if command -v ifstat >/dev/null; then
  ifstat -t 1 1
else
  echo "Install ifstat for live net usage: apt install ifstat"
  ip -s link | grep -A 1 "$(ip route show default | awk '/default/ {print $5}')"
fi

echo ""
echo "--- UPTIME & CONTEXT SWITCHES ---"
uptime
vmstat 1 2 | tail -n 1

echo ""
echo "--- TOP MEMORY USERS ---"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 10

if command -v sensors >/dev/null; then
  echo ""
  echo "--- TEMPERATURE ---"
  sensors
fi